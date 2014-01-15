
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
float x;
void setup() {
  size(800, 600);
  noStroke();
  background(255, .5);
  smooth();
  font = createFont("GeosansLight", 24);
  textFont(font);
  textAlign(CENTER, CENTER);

  connectTwitter();
  twitter.addListener(listener);
  twitter.filter(new FilterQuery().track(keywords));
  x = 0; // initializing headline off-screen to the right
}

void draw() {
  frameRate(5);
  //  fill(255,.5);
  //  rect(0, 0, width, height);
  background(255);
  //Put it somewhere random on the stage, with a random size and colour
  fill(0);
//  textSize(random(10, 30));

  textFont(font, 24);
  if (index>0) {
    println ("greater than zero");
    for (int i = 1; i<index; i++) {
        text(txt[index], x, height/2); //y=index+20
        //      text(txt[index], 10+frameCount, height/2); //y=index+20
      // Increment x
      x = x + 3;

      // If x is greater than the width, 
      // then it is off the screen
      float w = textWidth(txt[index]);
      if (x > w) {
        x = 0; 
  index = (index + 1) % txt.length;
      }
      delay(100);
    }
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

