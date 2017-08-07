//
//  CEFFileUtils.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2016. 12. 11..
//  Copyright © 2016. Tamas Lustyik. All rights reserved.
//

import Foundation

public struct CEFFileUtils {

    /// Creates a directory and all parent directories if they don't already exist.
    /// Returns true on successful creation or if the directory already exists. The
    /// directory is only readable by the current user. Calling this function on the
    /// browser process UI or IO threads is not allowed.
    /// CEF name: `CefCreateDirectory`
    @discardableResult
    public static func createDirectory(at path: String) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(path)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cef_create_directory(cefStrPtr) != 0
    }
    
    /// Get the temporary directory provided by the system.
    ///
    /// WARNING: In general, you should use the temp directory variants below instead
    /// of this function. Those variants will ensure that the proper permissions are
    /// set so that other users on the system can't edit them while they're open
    /// (which could lead to security issues).
    /// CEF name: `CefGetTempDirectory`
    public static var tempDirectory: String? {
        var cefStr = cef_string_t()
        let retval = cef_get_temp_directory(&cefStr)
        return retval != 0 ? CEFStringToSwiftString(cefStr) : nil
    }
    
    /// Creates a new directory. On Windows if |prefix| is provided the new directory
    /// name is in the format of "prefixyyyy". Returns true on success and sets
    /// |new_temp_path| to the full path of the directory that was created. The
    /// directory is only readable by the current user. Calling this function on the
    /// browser process UI or IO threads is not allowed.
    /// CEF name: `CefCreateNewTempDirectory`
    public static func createNewTempDirectory(prefix: String? = nil) -> String? {
        let cefStrPtr = prefix != nil ? CEFStringPtrCreateFromSwiftString(prefix!) : nil
        defer { CEFStringPtrRelease(cefStrPtr) }
        
        var cefPath = cef_string_t()
        let retval = cef_create_new_temp_directory(cefStrPtr, &cefPath)
        return retval != 0 ? CEFStringToSwiftString(cefPath) : nil
    }
    
    /// Creates a directory within another directory. Extra characters will be
    /// appended to |prefix| to ensure that the new directory does not have the same
    /// name as an existing directory. Returns true on success and sets |new_dir| to
    /// the full path of the directory that was created. The directory is only
    /// readable by the current user. Calling this function on the browser process
    /// UI or IO threads is not allowed.
    /// CEF name: `CefCreateTempDirectoryInDirectory`
    public static func createNewTempDirectory(within baseDirectory: String, prefix: String? = nil) -> String? {
        let cefBasePtr = CEFStringPtrCreateFromSwiftString(baseDirectory)
        defer { CEFStringPtrRelease(cefBasePtr) }
        let cefPrefixPtr = prefix != nil ? CEFStringPtrCreateFromSwiftString(prefix!) : nil
        defer { CEFStringPtrRelease(cefPrefixPtr) }
        
        var cefPath = cef_string_t()
        let retval = cef_create_temp_directory_in_directory(cefBasePtr, cefPrefixPtr, &cefPath)
        return retval != 0 ? CEFStringToSwiftString(cefPath) : nil
    }
    
    /// Returns true if the given path exists and is a directory. Calling this
    /// function on the browser process UI or IO threads is not allowed.
    /// CEF name: `CefDirectoryExists`
    public static func directoryExists(at path: String) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(path)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cef_directory_exists(cefStrPtr) != 0
    }
    
    /// Deletes the given path whether it's a file or a directory. If |path| is a
    /// directory all contents will be deleted.  If |recursive| is true any sub-
    /// directories and their contents will also be deleted (equivalent to executing
    /// "rm -rf", so use with caution). On POSIX environments if |path| is a symbolic
    /// link then only the symlink will be deleted. Returns true on successful
    /// deletion or if |path| does not exist. Calling this function on the browser
    /// process UI or IO threads is not allowed.
    /// CEF name: `CefDeleteFile`
    @discardableResult
    public static func deleteFile(at path: String, recursively: Bool) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(path)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cef_delete_file(cefStrPtr, recursively ? 1 : 0) != 0
    }
    
    /// Writes the contents of |src_dir| into a zip archive at |dest_file|. If
    /// |include_hidden_files| is true files starting with "." will be included.
    /// Returns true on success.  Calling this function on the browser process UI or
    /// IO threads is not allowed.
    /// CEF name: `CefZipDirectory`
    @discardableResult
    public static func zipDirectory(at path: String, to zipFilePath: String, includingHiddenFiles: Bool) -> Bool {
        let cefSrcPtr = CEFStringPtrCreateFromSwiftString(path)
        defer { CEFStringPtrRelease(cefSrcPtr) }
        let cefDstPtr = CEFStringPtrCreateFromSwiftString(zipFilePath)
        defer { CEFStringPtrRelease(cefDstPtr) }
        
        return cef_zip_directory(cefSrcPtr, cefDstPtr, includingHiddenFiles ? 1 : 0) != 0
    }
    
    /// Loads the existing "Certificate Revocation Lists" file that is managed by
    /// Google Chrome. This file can generally be found in Chrome's User Data
    /// directory (e.g. "C:\Users\[User]\AppData\Local\Google\Chrome\User Data\" on
    /// Windows) and is updated periodically by Chrome's component updater service.
    /// Must be called in the browser process after the context has been initialized.
    /// See https://dev.chromium.org/Home/chromium-security/crlsets for background.
    /// CEF name: `CefLoadCRLSetsFile`
    public static func loadCRLSetsFile(at path: String) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(path)
        defer { CEFStringPtrRelease(cefStrPtr) }
        
        cef_load_crlsets_file(cefStrPtr)
    }

}

