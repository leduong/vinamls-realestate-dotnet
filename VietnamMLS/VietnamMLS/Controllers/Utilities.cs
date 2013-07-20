using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Drawing;
using System.IO;
using System.Security.Cryptography;

namespace VietnamMLS.Controllers
{
    public static class Utilities
    {
        #region Image Handling

        /// <summary>
        /// Save an image as thumbnail
        /// </summary>
        /// <param name="imageFile">The image file to save</param>
        /// <param name="savedName">Save the image with this name</param>
        /// <param name="width">Resize the image to this width</param>
        /// <param name="height">Resize the image to this height</param>
        /// <returns>Save image succeeded or not</returns>
        public static bool SaveImage(HttpPostedFileBase imageFile, string savedName,
            int width, int height)
        {
            if (imageFile.ContentLength > 0 &&
                (imageFile.ContentType == "image/jpeg"
                || imageFile.ContentType == "image/pjpeg"
                || imageFile.ContentType == "image/png"
                || imageFile.ContentType == "image/bmp"
                || imageFile.ContentType == "image/gif"))
            {
                Image i = Image.FromStream(imageFile.InputStream);
                Image.GetThumbnailImageAbort myCallback =
                    new Image.GetThumbnailImageAbort(ThumbnailCallback);
                Image thumbnail = i.GetThumbnailImage(width, height, myCallback, IntPtr.Zero);

                string filePath = AppDomain.CurrentDomain.BaseDirectory +
                    @"Content\Images\" + savedName;
                thumbnail.Save(filePath, System.Drawing.Imaging.ImageFormat.Jpeg);

                return true;
            }
            return false;
        }
        private static bool ThumbnailCallback() { return false; }

        /// <summary>
        /// Save an image with orignal size
        /// </summary>
        /// <param name="imageFile">The image file to save</param>
        /// <param name="savedName">Save the image with this name</param>
        /// <returns>Save image succeeded or not</returns>
        public static bool SaveImage(HttpPostedFileBase imageFile, string savedName)
        {
            if (imageFile.ContentLength > 0 &&
                (imageFile.ContentType == "image/jpeg"
                || imageFile.ContentType == "image/pjpeg"
                || imageFile.ContentType == "image/png"
                || imageFile.ContentType == "image/bmp"
                || imageFile.ContentType == "image/gif"))
            {
                Image i = Image.FromStream(imageFile.InputStream);               
                string filePath = AppDomain.CurrentDomain.BaseDirectory +
                    @"Content\Images\" + savedName;
                i.Save(filePath, System.Drawing.Imaging.ImageFormat.Png);

                return true;
            }
            return false;
        }

        /// <summary>
        /// Delete a saved image
        /// </summary>
        /// <param name="imageLocation">Relative path to the image</param>
        /// <returns>Delete image succeeded or not</returns>
        public static bool DeleteImage(string imageLocation)
        {
            string filePath = AppDomain.CurrentDomain.BaseDirectory + @"Content\Images\" + imageLocation;
            if (File.Exists(filePath))
            {
                File.Delete(filePath);
                return true;
            }
            return false;
        }

        #endregion
        
        #region Search & SEO URL

        public static bool ContainsWord(this string dataString, string searchString)
        {
            string data = NormalizeString2(dataString);         
       
            string[] searchWords = NormalizeString2(searchString)
                .Split(" ".ToCharArray(), StringSplitOptions.RemoveEmptyEntries);

            foreach (string searchWord in searchWords)
            {
                if (data.Contains(searchWord))
                    return true;
            }
            return false;
        }


        /// <summary>
        /// Create SEO-friendly URL
        /// </summary>
        /// <param name="dataString">The string to create URL from</param>
        /// <returns>SEO-friendly URL</returns>
        public static string ProduceUrl(string dataString)
        {
            string[] words = dataString
                .Split(" ".ToCharArray(), StringSplitOptions.RemoveEmptyEntries);

            StringBuilder stringBuilder = new StringBuilder();
            foreach (string word in words)
            {
                string normalizedWord = NormalizeString(word);
                if (normalizedWord != string.Empty)
                {
                    stringBuilder.Append(normalizedWord + "-");
                }
            }

            if (string.IsNullOrEmpty(stringBuilder.ToString()))
            {
                return null;
            }
            stringBuilder.Remove(stringBuilder.Length - 1, 1);
            return stringBuilder.ToString();
        }

        /// <summary>
        /// Lower-case a string, remove accents and special characters
        /// </summary>
        /// <param name="stringToNormalize">The string needed to normalize</param>
        /// <returns>Normalized string</returns>
        private static string NormalizeString(string stringToNormalize)
        {
            StringBuilder stringBuilder = new StringBuilder();
            foreach (char c in stringToNormalize.ToLower().ToCharArray())
            {
                string normalizedChar = c.ToString()
                    .Normalize(NormalizationForm.FormD).Substring(0, 1);

                int ascii = (int)char.Parse(normalizedChar);
                if ((ascii >= 48 && ascii <= 57) || (ascii >= 97 && ascii <= 122))
                {
                    stringBuilder.Append(normalizedChar);
                }
            }
            return stringBuilder.ToString();
        }
        private static string NormalizeString2(string comparedString)
        {
            StringBuilder stringBuilder = new StringBuilder();
            
            foreach (char c in comparedString.Trim().ToLower().ToCharArray())
            {
                string normalizedChar = c.ToString()
                    .Normalize(NormalizationForm.FormD).Substring(0, 1);
                stringBuilder.Append(normalizedChar);
            }
            return stringBuilder.ToString();
        }
        #endregion

        #region Encrypt Password

        /// <summary>
        /// Encrypt a string
        /// </summary>
        /// <param name="inputString">The string to encrypt</param>
        /// <returns>Encrypted string</returns>
        public static string Encrypt(this string inputString)
        {
            UTF32Encoding u = new UTF32Encoding();
            byte[] bytes = u.GetBytes(inputString);
            SHA1 md = new SHA1CryptoServiceProvider();
            byte[] result = md.ComputeHash(bytes);
            return Convert.ToBase64String(result);
        }

        #endregion
    }
}