
// This is where you enter your Oauth info
static String OAuthConsumerKey = "YLYsc3WkrUc8zJpidXcnw";
static String OAuthConsumerSecret = "mEwWTHf2nbA01HCysg8llFE9Z3f7lbBsMhbuDVBT6g";
// This is where you enter your Access Token info
static String AccessToken = "372054045-7KAICklwZmhsjx6jj7Is7VSIYhXA6Xbu4VxU1JSm";
static String AccessTokenSecret = "h22GG2h0PI0eVaxdIzIl5xLr8659BxzZtmxpXHmXjyKww";

// if you enter keywords here it will filter, otherwise it will sample
String keywords[] = {"mind"
};

TwitterStream twitter = new TwitterStreamFactory().getInstance();
PImage img;
boolean imageLoaded;

void setup() {
  size(800, 600);
  noStroke();
  imageMode(CENTER);

  connectTwitter();
  twitter.addListener(listener);
  if (keywords.length==0) twitter.sample();
  else twitter.filter(new FilterQuery().track(keywords));
}

void draw() {
  background(0);
  if (imageLoaded) image(img, width/2, height/2);
}

// Initial connection
void connectTwitter() {
  twitter.setOAuthConsumer(OAuthConsumerKey, OAuthConsumerSecret);
  AccessToken accessToken = loadAccessToken();
  twitter.setOAuthAccessToken(accessToken);
}

// Loading up the access token
private static AccessToken loadAccessToken() {
  return new AccessToken(AccessToken, AccessTokenSecret);
}

// This listens for new tweet
StatusListener listener = new StatusListener() {
  public void onStatus(Status status) {

    //println("@" + status.getUser().getScreenName() + " - " + status.getText());

    String imgUrl = null;
    String imgPage = null;

    // Checks for images posted using twitter API

    if (status.getMediaEntities() != null) {
      imgUrl= status.getMediaEntities()[0].getMediaURL().toString();
    }
    // Checks for images posted using other APIs

    else {
      if (status.getURLEntities().length > 0) {
        if (status.getURLEntities()[0].getExpandedURL() != null) {
          imgPage = status.getURLEntities()[0].getExpandedURL().toString();
        }
        else {
          if (status.getURLEntities()[0].getDisplayURL() != null) {
            imgPage = status.getURLEntities()[0].getDisplayURL().toString();
          }
        }
      }

      if (imgPage != null) imgUrl  = parseTwitterImg(imgPage);
    }

    if (imgUrl != null) {

      println("found image: " + imgUrl);

      // hacks to make image load correctly

      if (imgUrl.startsWith("//")){
        println("s3 weirdness");
        imgUrl = "http:" + imgUrl;
      }
      if (!imgUrl.endsWith(".jpg")) {
        byte[] imgBytes = loadBytes(imgUrl);
        saveBytes("tempImage.jpg", imgBytes);
        imgUrl = "tempImage.jpg";
      }

      println("loading " + imgUrl);
      img = loadImage(imgUrl);
      imageLoaded = true;
    }
  }

  public void onDeletionNotice(StatusDeletionNotice statusDeletionNotice) {
    //System.out.println("Got a status deletion notice id:" + statusDeletionNotice.getStatusId());
  }
  public void onTrackLimitationNotice(int numberOfLimitedStatuses) {
    //  System.out.println("Got track limitation notice:" + numberOfLimitedStatuses);
  }
  public void onScrubGeo(long userId, long upToStatusId) {
    System.out.println("Got scrub_geo event userId:" + userId + " upToStatusId:" + upToStatusId);
  }

  public void onException(Exception ex) {
    ex.printStackTrace();
  }
};


// Twitter doesn't recognize images from other sites as media, so must be parsed manually
// You can add more services at the top if something is missing

String parseTwitterImg(String pageUrl) {

  for (int i=0; i<imageService.length; i++) {
    if (pageUrl.startsWith(imageService[i][0])) {

      String fullPage = "";  // container for html
      String lines[] = loadStrings(pageUrl); // load html into an array, then move to container
      for (int j=0; j < lines.length; j++) { 
        fullPage += lines[j] + "\n";
      }

      String[] pieces = split(fullPage, imageService[i][1]);
      pieces = split(pieces[1], "\""); 

      return(pieces[0]);
    }
  }
  return(null);
}

