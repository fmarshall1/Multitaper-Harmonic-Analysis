#Francois Marshall
#Postdoctoral assistant under the supervision of Dr. Mark Kramer
#Mathematics and Statistics
#Boston University
#2021
##################################################################################

######################################################################################################################################
#Starting analysis.
######################################################################################################################################

#Global tic.
tic()

nested_directory.input_strings<-paste("",sep="")
source_directory_initialization.object<-
  source_directory_initialization.function(main_directory_string.par=main_directory.string,
                                           specific_subdirectory_string.par=specific_subdirectory.string,
                                           nested_directory_strings.par=nested_directory.input_strings)
working_directory.string<-source_directory_initialization.object$out.working_directory_string
working_directory.string0<-working_directory.string
specific_subdirectory.string0<-specific_subdirectory.string

##################################################################################
#Create and set the working directory.
##################################################################################
directory.strings<-c("1_Preliminary_Analysis")
create_and_set_multiple_directories.object<-
  create_and_set_multiple_directories.function(directory_strings.par=directory.strings,
                                               specific_subdirectory_string.par=specific_subdirectory.string0,
                                               working_directory_string.par=
                                                 paste(working_directory.string0,
                                                       "/",sep=""))
specific_subdirectory.string<-create_and_set_multiple_directories.object$out.specific_subdirectory_string
working_directory.string<-create_and_set_multiple_directories.object$out.working_directory_string
revised.specific_directory_string<-create_and_set_multiple_directories.object$out.revised_specific_subdirectory_string

setwd(working_directory.string)

temp.ts_parameters_directory_name<-paste(working_directory.string,"../Data/Parameters",sep="")
temp.ts_parameters_directory_files_list<-list.files(temp.ts_parameters_directory_name)
temp.ts_directory_name<-paste(working_directory.string,"../Data/Time_Series",sep="")
temp.ts_directory_files_list<-list.files(temp.ts_directory_name)

temp.parameter_file_name<-paste(code.string,"/Data/Parameters/",temp.ts_parameters_directory_files_list[[1]],sep="")
temp.ts_file_name<-paste(code.string,"/Data/Time_Series/",temp.ts_directory_files_list[[1]],sep="")

setwd(working_directory.string)


temp.num_sections=length(selected_time_window.indices)

temp.initial_working_directory_string<-working_directory.string
temp.initial_revised_specific_directory_string<-revised.specific_directory_string
temp.initial_specific_subdirectory_string<-specific_subdirectory.string

temp.section_index_i=1

for(temp.i in 1:temp.num_sections){
  tic()
  if(temp.num_sections==1){
    temp.section_index_i=selected_time_window.indices
  } else{
    temp.section_index_i=selected_time_window.indices[temp.i]
  }
  
  temp.subDir_string_i<-paste("Section_",temp.section_index_i,sep="")
  dir.create(temp.subDir_string_i,showWarnings=FALSE)
  working_directory.string<-paste(temp.initial_working_directory_string,temp.subDir_string_i,"/",sep="")
  revised.specific_directory_string<-paste(temp.initial_revised_specific_directory_string,temp.subDir_string_i,"/",sep="")
  specific_subdirectory.string<-paste(temp.initial_specific_subdirectory_string,temp.subDir_string_i,"/",sep="")
  setwd(working_directory.string)
  
  sink("Output_File.txt", append=FALSE, split=FALSE)
  
  ######################################################################################################################################################
  #Plot the pre-recruitment window, where the term for the time window in question is based on the slideshow.
  #Below, the choice of time window is from "Starting_Considerations/Voltage_Series_Raw_Sections.pdf", where the time window contains
  #a section series exhibiting periodicity.
  ######################################################################################################################################################
  temp.application_TS_text_input_object<-
    TS_data_upload_text.function(file_name.par=temp.ts_file_name,ts_parameters_file.par=temp.parameter_file_name,
                                 time_window_index.par=temp.section_index_i,
                                 x_measurement.par=measured_abscissa.string,record_size.par=N.par,
                                 y_measurement.par=measure_quantity.string,time_units.par=time_units.string,
                                 abbreviated_time_units_string.par=abbreviated_time_units.string,
                                 y_units.par=measure_units.string,
                                 pdf_title.par=paste("Section_",measure_quantity.string,"_Series_Raw.pdf",sep=""),
                                 x_scale.par=plotting.time_scale,y_scale.par=plotting.voltage_scale,plot.par=plot_ts.bool,
                                 num_plotting.par=num.plotting_points,header.par=FALSE)
  temp.truncated_ts_series<-temp.application_TS_text_input_object$out.truncated_voltages
  N.samples=temp.application_TS_text_input_object$out.N_samples
  truncated.times<-temp.application_TS_text_input_object$out.truncated_times
  sampling.rate=temp.application_TS_text_input_object$out.sampling_rate
  sampling.period=temp.application_TS_text_input_object$out.sampling_period
  temp.N=length(truncated.times)
  temp.index_sequence<-1:temp.N
  
  #if(FALSE){
  
  temp.single_section_harmonic_ACS_analysis_object<-
    single_section_harmonic_ACS_analysis.function(index.par=1,
                                                  time_sequence.par=truncated.times,ts.par=temp.truncated_ts_series,
                                                  M_exponent.par=1,
                                                  changepoint_times.par=truncated.times[c(1,temp.N)],
                                                  epoch_labels.par=rep("Section",2),NW.par=NW.par,
                                                  truncation_bool.par=truncation_bool.par,
                                                  #Spectral and harmonic analyses.
                                                  sampling_rate.par=sampling.rate,
                                                  first_time.par=truncated.times[1],
                                                  start_time.par=0,F_test_threshold.par=F_test.threshold,
                                                  threshold_crossings_LB.par=N.F_statistics,num_sections.par=2,
                                                  measured_quantity.par=measure_quantity.string,
                                                  measured_units.par=measure_units.string,
                                                  reconstruction_directory.par=paste(working_directory.string,"1_Section/",
                                                                                     spectral_power_directory_string.par,sep=""),
                                                  spectral_power_directory_string.par=spectral_power_directory_string.par,
                                                  old_directory.par=working_directory.string,
                                                  jackknife.par=jk_spectral_power.bool,F_test_jackknife.par=F_test_jackknife.par,
                                                  plot.par=plot_spectral_power.bool,
                                                  output.par=output.spectral_power,spectral_power_bool.par=TRUE,
                                                  jk_output.par=output.jk_spectral_power,ha_bool.par=ha_bool.par,
                                                  residual_bool.par=residual_eigencoeffs.bool,
                                                  reconstruction_bool.par=residual_eigencoeffs.bool,
                                                  verbose.par=multitaper_spectral_power_verbose.par,
                                                  cepstral_bool.par=cepstral_analysis.bool,
                                                  ends_reconstruction_bool.par=TRUE,
                                                  F_test_diagnostics_bool.par=FALSE,
                                                  #Eigencoefficient analysis parameters.
                                                  eigencoeff_analysis_bool.par=eigencoeff_analysis_bool.par,
                                                  #Cyclic analysis parameters.
                                                  cepstral_analysis_bool.par=cepstral_analysis.bool,
                                                  cepstral_F_threshold.par=F_test.threshold,
                                                  Rsq_threshold.par=Rsq_threshold.par,
                                                  Kolmogorov_percentile.par=Kolmogorov_percentile.par,
                                                  TPT_threshold.par=TPT_threshold.par,
                                                  outlier_percentile.par=outlier_percentile.par,
                                                  units.par1=frequency_units.string,units.par2=measure_units.string,
                                                  cepstral_measured_quantity.par=cepstral_measured_quantity.par,
                                                  cepstral_power_directory_string.par=cepstral_power_directory_string.par,
                                                  specific_subdirectory_string.par=specific_subdirectory.string,
                                                  ts_interp_bool.par=ts_interp_bool.par,mdss_bool.par=mdss_bool.par,
                                                  remove_outliers_bool.par=remove_outliers_bool.par,
                                                  residual_eigencoeffs_bool.par=cepstral_residual_eigencoeffs.bool,
                                                  whitened_log_spectrum_bool.par=whitened_log_spectrum_bool.par,
                                                  cleaned_log_spectrum_bool.par=cleaned_log_spectrum_bool.par,
                                                  plot_quadratic_diagnostics_bool.par=plot_quadratic_diagnostics_bool.par,
                                                  cepstral_jk_spectral_power_bool.par=cepstral_jk_spectral_power.bool,
                                                  cepstral_units.par=cepstral_units.par,cepstral_output.par=cepstral_output.par,
                                                  cepstral_plot_spectral_power_bool.par=cepstral_plot_spectral_power.bool,
                                                  cepstral_power_bool.par=cepstral_power.bool,
                                                  cepstral_output_jk_spectral_power.par=cepstral_output.jk_spectral_power,
                                                  cepstral_ha_bool.par=cepstral_ha_bool.par,
                                                  cepstral_residual_eigencoeffs_bool.par=cepstral_residual_eigencoeffs.bool,
                                                  cepstral_power.verbose_par=cepstral_power.verbose_par,
                                                  #Ends reconstruction booleans, mean computations.
                                                  num_iterations.par=num_iterations.ends_interpolation_harmonic,
                                                  max_length.par=max_length.ends_interpolation_harmonic,
                                                  main_directory_string.par=main_directory.string,
                                                  directory_label.par=
                                                    paste("Multitaper_Spectral_Power/Means_Ends_Reconstruction",sep=""),
                                                  old_directory_interp.par=working_directory.string,
                                                  revised_specific_directory_string.par=revised.specific_directory_string,
                                                  periodic_reconstruction_bool.par=TRUE,ts_interp_ends_bool.par=FALSE,
                                                  mdss_bool_ends.par=FALSE,gn_bool_ends.par=FALSE,eigencoeff_plot_bool.par=FALSE,
                                                  cyclic_ACVS_bool.par=cyclic_ACVS.bool,verbose_bool.par=TRUE)
  temp.time_vector<-temp.single_section_harmonic_ACS_analysis_object$out.time_vector
  temp.mean_signal<-temp.single_section_harmonic_ACS_analysis_object$out.mean_vector
  temp.harmonic_coefficients<-temp.single_section_harmonic_ACS_analysis_object$out.harmonic_coefficients
  temp.all_section_significant_frequencies<-
    temp.single_section_harmonic_ACS_analysis_object$out.all_section_significant_frequencies
  
  #}#endif
  
  sink()
  
  sink("Total_Computation_Time.txt", append=FALSE, split=FALSE)
  cat("Time for all computations = ")
  toc()
  sink()
  
  
  closeAllConnections()
  graphics.off()
  
  setwd(temp.initial_working_directory_string)
  
}#end for loop

if(temp.num_sections>1){
  sink("Total_Computation_Time.txt", append=FALSE, split=FALSE)
  cat("Time for all computations = ")
  toc()
  sink()
}




