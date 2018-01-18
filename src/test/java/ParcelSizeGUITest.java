package test.java;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.fail;

import java.util.concurrent.TimeUnit;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.openqa.selenium.Alert;
import org.openqa.selenium.By;
import org.openqa.selenium.NoAlertPresentException;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;



public class ParcelSizeGUITest {
  private WebDriver driver;
  private String baseUrl;
  private boolean acceptNextAlert = true;
  private StringBuffer verificationErrors = new StringBuffer();

  @Before
  public void setUp() throws Exception {
	  
    driver = new ChromeDriver();
    baseUrl = "https://www.katalon.com/";
    driver.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
  }

  @Test
  public void testParcelSizeGUI() throws Exception {
    driver.get("http://localhost:8080/SWA%5FParcelService/");
    driver.findElement(By.cssSelector("input.w3-input.ng-pristine.ng-untouched.ng-valid.ng-not-empty")).click();
    driver.findElement(By.xpath("//input")).clear();
    driver.findElement(By.xpath("//input")).sendKeys("20");
    driver.findElement(By.cssSelector("input.w3-input.ng-pristine.ng-untouched.ng-valid.ng-not-empty")).click();
    driver.findElement(By.xpath("//input[2]")).clear();
    driver.findElement(By.xpath("//input[2]")).sendKeys("20");
    driver.findElement(By.cssSelector("input.w3-input.ng-pristine.ng-untouched.ng-valid.ng-not-empty")).click();
    driver.findElement(By.xpath("//input[3]")).clear();
    driver.findElement(By.xpath("//input[3]")).sendKeys("20");
    driver.findElement(By.cssSelector("button.w3-btn.w3-teal")).click();
    Thread.sleep(500);
    assertEquals("Paketgröße: S", driver.findElement(By.id("cfg-size-res")).getText());
  }

  @After
  public void tearDown() throws Exception {
    driver.quit();
    String verificationErrorString = verificationErrors.toString();
    if (!"".equals(verificationErrorString)) {
      fail(verificationErrorString);
    }
  }

  private boolean isElementPresent(By by) {
    try {
      driver.findElement(by);
      return true;
    } catch (NoSuchElementException e) {
      return false;
    }
  }

  private boolean isAlertPresent() {
    try {
      driver.switchTo().alert();
      return true;
    } catch (NoAlertPresentException e) {
      return false;
    }
  }

  private String closeAlertAndGetItsText() {
    try {
      Alert alert = driver.switchTo().alert();
      String alertText = alert.getText();
      if (acceptNextAlert) {
        alert.accept();
      } else {
        alert.dismiss();
      }
      return alertText;
    } finally {
      acceptNextAlert = true;
    }
  }
}
