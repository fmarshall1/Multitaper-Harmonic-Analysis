#Francois Marshall
#Postdoctoral assistant under the supervision of Dr. Mark Kramer
#Mathematics and Statistics
#Boston University
#2021
##################################################################################

#Header file for the preliminary analysis of application data acquired by NY and BU.

#Global variables.
specific_header_file.string<<-"Time_Series_Header.R"
spectral_power_directory_string.par<<-"Multitaper_Spectral_Power"
harmonic_analysis_directory_string.par<<-"Voltage_Multitaper_F_Test/"
residual_PSD_interpolation_string.par<<-"Interpolation/"
residual_spectral_power_directory_string.par<<-"Residual_Multitaper_Spectral_Power"
cepstral_harmonic_analysis_directory_string.par<<-"Cepstral_Multitaper_F_Test"
cepstral_measure_quantity.string<<-"Log spectral power"
cepstral_measure_quantity_string.lower_case<<-"log spectral power"
cepstral_measure_units.string<<-paste("Log ",measure_units.string," per ",frequency_units.string,sep="")

header.directory<<-paste(main_directory.string,"General_Headers/Time_Series_Header.R",sep="")
source(header.directory)

###################################################################################################################





















