setwd('/app')
library(optparse)
library(jsonlite)

if (!requireNamespace("aws.s3", quietly = TRUE)) {
	install.packages("aws.s3", repos="http://cran.us.r-project.org")
}
library(aws.s3)


secret_s3_access_key = Sys.getenv('secret_s3_access_key')
secret_s3_secret_key = Sys.getenv('secret_s3_secret_key')

print('option_list')
option_list = list(

make_option(c("--acolite_processing"), action="store", default=NA, type="character", help="my description"),
make_option(c("--param_s3_server"), action="store", default=NA, type="character", help="my description"),
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

print("Retrieving acolite_processing")
var = opt$acolite_processing
print(var)
var_len = length(var)
print(paste("Variable acolite_processing has length", var_len))

print("------------------------Running var_serialization for acolite_processing-----------------------")
print(opt$acolite_processing)
acolite_processing = var_serialization(opt$acolite_processing)
print("---------------------------------------------------------------------------------")

print("Retrieving param_s3_server")
var = opt$param_s3_server
print(var)
var_len = length(var)
print(paste("Variable param_s3_server has length", var_len))

param_s3_server <- gsub("\"", "", opt$param_s3_server)
id <- gsub('"', '', opt$id)


print("Running the cell")
acolite_processing


Sys.setenv(
    "AWS_ACCESS_KEY_ID" = secret_s3_access_key,
    "AWS_SECRET_ACCESS_KEY" = secret_s3_secret_key,
    "AWS_S3_ENDPOINT" = param_s3_server
    )

download_files_from_minio <- function(bucket, folder, local_path) {
  
  objects <- get_bucket(bucket = bucket, prefix = folder, region="nl-uvalight")
  
  for (object in objects) {
    file_name <- basename(object$Key)
    local_file_path <- file.path(local_path, file_name)
    cat("Downloading", object$Key, "to", local_file_path, "\n")
    
    save_object(object = object$Key, bucket = bucket, file = local_file_path, region="nl-uvalight")
    
    cat("File", object$Key, "downloaded successfully.\n")
  }
}

bucket_name <- "naa-vre-waddenzee-shared"  # Replace with your bucket name
minio_folder <- "protoDT_WadPP/Input_data/processed_results/"  # Replace with your folder in the bucket
local_folder <- "/tmp/data/processed_results"  # Replace with the local folder path

if (!dir.exists(local_folder)) {
  dir.create(local_folder, recursive = TRUE)
}

download_files_from_minio(bucket = bucket_name, folder = minio_folder, local_path = local_folder)
