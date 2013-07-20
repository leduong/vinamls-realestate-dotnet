using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace VietnamMLS.Helpers
{
    public static class ImageExtensions
    {
        public static string Image(this HtmlHelper helper,
                                string url)
        {
            TagBuilder builder = new TagBuilder("image");
            builder.Attributes.Add("src", url);
            return builder.ToString(TagRenderMode.SelfClosing);
        }

        public static string Image(this HtmlHelper helper,
                                string url,
                                string altText)
        {
            TagBuilder builder = new TagBuilder("image");
            builder.Attributes.Add("src", url);
            builder.Attributes.Add("alt", altText);
            return builder.ToString(TagRenderMode.SelfClosing);
        }

        public static string Image(this HtmlHelper helper,
                                string url,
                                string altText,
                                object htmlAttributes)
        {
            TagBuilder builder = new TagBuilder("image");
            builder.Attributes.Add("src", url);
            builder.Attributes.Add("alt", altText);
            builder.MergeAttributes(new RouteValueDictionary(htmlAttributes));
            return builder.ToString(TagRenderMode.SelfClosing);
        }
    }
}