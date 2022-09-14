
#' Download Source Files
#'
#' \code{download_source_files} ...
#'
#' @details ...
#' The \code{download_source_files} ...
#'
#' @param host_name Character, 
#'
#' @param device_name Character, 
#' 
#' @param user_name Character, 
#' 
#' @param source_path Character, 
#' 
#' @param destination_path Character, 
#'
#' @return ...
#'
#' @examples
#'
#'
#'
#' @export


download_source_files <- function(host_name, 
                                  device_name,
                                  user_name,
                                  source_path,
                                  destination_path) {

        # Connect remotely to pi using an ssh connection.
        # Keyring package used to securely obtain credentials for host login.
        
        session <- ssh::ssh_connect(host = host_name,
                                    passwd = keyring::key_get(device_name, user_name),
                                    verbose = FALSE)
        
        # Use scp protocol to download files from the host via the specified
        # directories.
        
        ssh::scp_download(session,
                          files = source_path,
                          to = destination_path,
                          verbose = TRUE)
        
        # Disconnect from ssh connection.
        
        ssh::ssh_disconnect(session)

}
