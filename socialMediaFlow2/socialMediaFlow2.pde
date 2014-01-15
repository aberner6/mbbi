
//Oauth info
static String OAuthConsumerKey = "YLYsc3WkrUc8zJpidXcnw";
static String OAuthConsumerSecret = "mEwWTHf2nbA01HCysg8llFE9Z3f7lbBsMhbuDVBT6g";

//Access Token info
static String AccessToken = "372054045-7KAICklwZmhsjx6jj7Is7VSIYhXA6Xbu4VxU1JSm";
static String AccessTokenSecret = "h22GG2h0PI0eVaxdIzIl5xLr8659BxzZtmxpXHmXjyKww";

//Filter these keywords
String keywords[] = {
  "my mind"
};
String[] txt=new String[1000000];
String[] other=new String[1000000];

String pieces;


TwitterStream twitter = new TwitterStreamFactory().getInstance();

PFont font;

int index = 0;
//String txt ="";
//float x;

PImage img;
float x = 800;
int offsetX;

void setup() {
  size(1000, 400);
  colorMode(HSB, 360, 100, 100, 100);
    img = loadImage("trans.gif");
  smooth();
  font = createFont("GeosansLight", 24);
  textFont(font);
  frameRate(30);
  smooth();
  noStroke();
  textAlign(CENTER, CENTER);

  connectTwitter();
 twitter.addListener(listener);
  twitter.filter(new FilterQuery().track(keywords));
  //  x = 0; // initializing headline off-screen to the right
}

void draw() {

  background(0);
  randomSeed(0);
  int y = height/2;

//  if (frameCount%(30*60*5)==0) {
//    twitter.addListener(listener);
//    twitter.filter(new FilterQuery().track(keywords));
//  }
      fill(360);

  if (index>0) {

    for (int i = 1; i<index; i++) {

      text(txt[index], x+offsetX, y); //y=index+20

      offsetX += textWidth(txt[index]);
    }
  image(img, -30, 0, 220, height);
  pushMatrix();
  rotate( PI);
  image(img, -width-30, -height, 220, height);
  popMatrix();
  x-=5;
    if (x<-offsetX-10) x = width+10;
    offsetX = 0;
  }
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
    for (int i = 1; i<txt.length; i++) {
      //      other[i] = status.getText();
      //      if (other[i].equals(other[i-1])) {
      //      }
      //      else {
      //        txt[i]= other[i];
      //      }
      txt[i]= status.getText();
    }
    index++;
    println(status.getText());
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

