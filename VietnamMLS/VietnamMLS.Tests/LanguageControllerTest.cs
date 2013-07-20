using System;
using System.Text;
using System.Collections.Generic;
using System.Linq;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using VietnamMLS.Controllers;
using System.Web.Mvc;

namespace VietnamMLS.Tests
{
    /// <summary>
    /// Summary description for LanguageControllerTest
    /// </summary>
    [TestClass]
    public class LanguageControllerTest
    {
        public LanguageControllerTest()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        private TestContext testContextInstance;

        /// <summary>
        ///Gets or sets the test context which provides
        ///information about and functionality for the current test run.
        ///</summary>
        public TestContext TestContext
        {
            get
            {
                return testContextInstance;
            }
            set
            {
                testContextInstance = value;
            }
        }

        #region Additional test attributes
        //
        // You can use the following additional attributes as you write your tests:
        //
        // Use ClassInitialize to run code before running the first test in the class
        // [ClassInitialize()]
        // public static void MyClassInitialize(TestContext testContext) { }
        //
        // Use ClassCleanup to run code after all tests in a class have run
        // [ClassCleanup()]
        // public static void MyClassCleanup() { }
        //
        // Use TestInitialize to run code before running each test 
        // [TestInitialize()]
        // public void MyTestInitialize() { }
        //
        // Use TestCleanup to run code after each test has run
        // [TestCleanup()]
        // public void MyTestCleanup() { }
        //
        #endregion

        [TestMethod]
        public void DetailsAction_Should_Return_View_For_ExistingLanguage()
        {
            var controller = new LanguageController();
            var result = controller.Details(1) as ViewResult;
            Assert.IsNotNull(result, "Expected View");
        }

        [TestMethod]
        public void DetailsAction_Should_Return_NotFoundView_For_NonexistingLanguage()
        {
            var controller = new LanguageController();
            var result = controller.Details(999) as ViewResult;
            Assert.AreEqual("NotFound", result.ViewName);
        }

    }
}
