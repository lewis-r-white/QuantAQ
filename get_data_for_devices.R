#' Get data for devices from Quant AQ
#'
#' @param start_date character, yyyy-mm-dd
#' @param end_date character, yyyy-mm-dd
#' @param device_names list of characters,
#'
#' @return dataframe with observations for each device between the date range of interest 
#' @export
#'
#' @examples
#' 
#' start_date <- as.Date("2023-10-15")
#' end_date <- as.Date("2023-11-12")
#' device_names <- c("MOD-PM-00826", "MOD-PM-00847")
#' 
#' result_df <- get_data_for_devices(start_date, end_date, device_names)


# Function to get data by date, handling errors
get_data_safe <- possibly(get_data_by_date, otherwise = NULL)

# Function to get data for each device within the dates specfied
get_data_for_devices <- function(start_date, end_date, device_names) {
  
  # Use map to get data for each device and date, handling errors
  result_df <- map_df(device_names, function(device) {
    result_list <- map(seq(start_date, end_date, by = "days"), function(date) {
      formatted_date <- format(date, "%Y-%m-%d")
      get_data_safe(sn = device, date = formatted_date)
    }) %>%
      # Filter out NULL elements (empty lists)
      discard(~ is.null(.x) || length(.x) == 0) %>%
      # Convert each element to a data frame
      map(as.data.frame)
    
    # Combine the list of data frames into a single data frame
    result_df_device <- do.call(rbind, result_list) %>%
      
      #fill in the missing time gaps
      mutate(timestamp = as.POSIXct(timestamp)) %>%
      mutate(timestamp = format(timestamp, "%Y-%m-%d %H:%M")) %>%
      mutate(timestamp2 = as.POSIXct(timestamp)) %>%
      complete(timestamp2 = seq.POSIXt(min(timestamp2), max(timestamp2), by = "min")) %>%
      mutate(date = as.Date(timestamp2)) %>%
      mutate(hour = hour(ymd_hms(timestamp2))) %>%
      mutate(monitor = device) %>%
      select(monitor, everything())
      
    
    return(result_df_device)
  })
  
  return(result_df)
}


