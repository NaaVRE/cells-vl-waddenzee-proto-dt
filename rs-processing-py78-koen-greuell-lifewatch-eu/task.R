setwd('/app')
library(optparse)
library(jsonlite)



secret_copernicus_api = Sys.getenv('secret_copernicus_api')
secret_s3_access_key = Sys.getenv('secret_s3_access_key')
secret_s3_secret_key = Sys.getenv('secret_s3_secret_key')

print('option_list')
option_list = list(

make_option(c("--param_something"), action="store", default=NA, type="character", help="my description"),
make_option(c("--path_ids"), action="store", default=NA, type="character", help="my description"),
make_option(c("--id"), action="store", default=NA, type="character", help="task id")
)


opt = parse_args(OptionParser(option_list=option_list))

var_serialization <- function(var){
    if (is.null(var)){
        print("Variable is null")
        exit(1)
    }
    tryCatch(
        {
            var <- fromJSON(var)
            print("Variable deserialized")
            return(var)
        },
        error=function(e) {
            print("Error while deserializing the variable")
            print(var)
            var <- gsub("'", '"', var)
            var <- fromJSON(var)
            print("Variable deserialized")
            return(var)
        },
        warning=function(w) {
            print("Warning while deserializing the variable")
            var <- gsub("'", '"', var)
            var <- fromJSON(var)
            print("Variable deserialized")
            return(var)
        }
    )
}

print("Retrieving param_something")
var = opt$param_something
print(var)
var_len = length(var)
print(paste("Variable param_something has length", var_len))

param_something <- gsub("\"", "", opt$param_something)
print("Retrieving path_ids")
var = opt$path_ids
print(var)
var_len = length(var)
print(paste("Variable path_ids has length", var_len))

print("------------------------Running var_serialization for path_ids-----------------------")
print(opt$path_ids)
path_ids = var_serialization(opt$path_ids)
print("---------------------------------------------------------------------------------")

id <- gsub('"', '', opt$id)


print("Running the cell")

# capturing outputs
print('Serialization of acolite_processing')
file <- file(paste0('/tmp/acolite_processing_', id, '.json'))
writeLines(toJSON(acolite_processing, auto_unbox=TRUE), file)
close(file)
