
#' Download Source Files
#'
#' \code{download_source_files} uses an ssh connection to connect to and download
#' source files from a remote device on a wifi network.
#'
#' @details ... add notes on use of keyring package and Windows Credentials to securely
#' pass a password to this function.
#' 
#' The \code{download_source_files} uses functions in the `ssh` R library.
#'
#' @param host_name Character, an ssh server string in the format `[user@]hostname[:port]`.
#' 
#' @param use_keyring Boolean, if TRUE, ....
#'
#' @param device_name Character, the name of the remote device.
#' 
#' @param user_name Character, the name of the user accessing the device.
#' 
#' @param password Character, if not using a keyring ...
#' 
#' @param source_path Character, the file path to the source files to download.
#' 
#' @param destination_path Character, the file path to the destination folder
#' to which the source files should be downloaded.
#'
#' @examples
#'
#'
#'
#' @export

download_source_files <- function(host_name,
                                  use_keyring = TRUE,
                                  device_name,
                                  user_name,
                                  password,
                                  source_path,
                                  destination_path) {

        # Connect remotely to pi using an ssh connection.
        # Keyring package used to securely obtain credentials for host login.
        
        if(use_keyring == TRUE) {
            
                session <- ssh::ssh_connect(host = host_name,
                                            passwd = keyring::key_get(device_name, user_name),
                                            verbose = FALSE)
            
        } else {
            
                session <- ssh::ssh_connect(host = host_name,
                                            passwd = password,
                                            verbose = FALSE)
            
        }
    

        
        # Use scp protocol to download files from the host via the specified
        # directories.
        
        ssh::scp_download(session,
                          files = source_path,
                          to = destination_path,
                          verbose = TRUE)
        
        # Disconnect from ssh connection.
        
        ssh::ssh_disconnect(session)

}
