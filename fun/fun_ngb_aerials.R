ngb_aerials <- function(aerial_files, step = 2000){
  require(tools)
  ngb_files <- lapply(basename(aerial_files), function(act_file){
    
    # Get names without path to compare names although path might be different
    act_ext <- file_ext(act_file)
    fnames <- basename(aerial_files)
    
    # Get x and y coordinates of actual file from filename
    act_file_x <- as.numeric(substr(act_file, 1, 6))
    act_file_y <- as.numeric(substr(act_file, 8, 14))
    
    # Set neighbours starting from north with clockwise rotation (N, E, S, W)
    pot_ngb <- c(paste0(act_file_x, "_", act_file_y + step, ".", act_ext),
                 paste0(act_file_x + step, "_", act_file_y, ".", act_ext),
                 paste0(act_file_x, "_", act_file_y - step, ".", act_ext),
                 paste0(act_file_x - step, "_", act_file_y, ".", act_ext))
    
    # Check if neighburs exist and create vector with full filepath
    act_ngb <- sapply(pot_ngb, function(f){
      pos <- grep(f, fnames)
      if(length(pos) > 0){
        return(aerial_files[pos])
      } else {
        return(NA)
      }
    })
    return(act_ngb)
  })
  
  names(ngb_files) <- aerial_files
  return(ngb_files)
  
}