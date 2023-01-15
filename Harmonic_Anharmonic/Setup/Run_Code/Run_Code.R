#Francois Marshall
#Postdoctoral assistant under the supervision of Prof. Mark Kramer
#Mathematics and Statistics
#Boston University
#2021
##################################################################################

#Always set the string below so that the code is run from the directory containing "Code".
current_directory.string<-dirname(rstudioapi::getSourceEditorContext()$path)
setwd(current_directory.string)
user_specific_directory.string<-"../../../"
setwd(user_specific_directory.string)
user_specific_directory.string<-paste(getwd(),"/",sep="")
selected_time_window.index=NA

#The variable, "main_directory.string", below specifies the home directory to be the one where the "General_Headers" directory is included.
main_directory.string<<-paste(user_specific_directory.string,sep="")
#The name of the directory under where the project is to be stored.
source.directory<<-""
#Name of the directory under source.directory containing the code to be run.
code.string<<-"Harmonic_Anharmonic"


################################################################################################################################################
################################################################################################################################################
#No user action required
################################################################################################################################################
################################################################################################################################################

#Require the pracma library installed in order to compare between strings in the initialization file with strcmp.
if(!require("devtools")){
  install.packages("devtools")
}
library("devtools")
if(!require("pracma",character.only=TRUE)){
  install_github("cran/pracma")
}
library("pracma")
######################################################################################################################################
#Read the parameter-initialization and header files, set the working directory, and open a new sink for output.
######################################################################################################################################
specific_subdirectory1.string<-paste(main_directory.string,source.directory,code.string,sep="")
source(paste(main_directory.string,"General_Headers/Constants.R",sep=""))
source(paste(main_directory.string,"General_Headers/Source_Code_Initialization.R",sep=""))
header.file<-paste(main_directory.string,source.directory,code.string,"/Setup/Application_Headers/Preliminary_Analysis.R",sep="")
#Initialize the parameters.
source(paste(specific_subdirectory1.string,"/Parameter_Initialization/Parameter_Initialization.R",sep=""))
#Read all the instructions of the header file.
source(header.file)

specific_subdirectory.string<-paste(source.directory,code.string,"/",sep="")
if(!is.na(selected_time_window.index)){
  specific_subdirectory.string<-paste(source.directory,code.string,"/Section_",selected_time_window.index,"/",sep="")
}

#Set the working directory.
working_directory.string<-paste(main_directory.string,source.directory,code.string,"/",sep="")
source(paste(working_directory.string,"/",code.string,".R",sep=""),chdir=TRUE)









