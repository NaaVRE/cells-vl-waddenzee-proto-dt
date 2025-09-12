setwd('/app')
library(optparse)
library(jsonlite)




print('option_list')
option_list = list(

make_option(c("--number"), action="store", default=NA, type="integer", help="my description"),
make_option(c("--param_constant"), action="store", default=NA, type="integer", help="my description"),
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

print("Retrieving number")
var = opt$number
print(var)
var_len = length(var)
print(paste("Variable number has length", var_len))

number = opt$number
print("Retrieving param_constant")
var = opt$param_constant
print(var)
var_len = length(var)
print(paste("Variable param_constant has length", var_len))

param_constant = opt$param_constant
id <- gsub('"', '', opt$id)


print("Running the cell")
constant = 2
new_num = number + constant + param_constant
print(new_num)
