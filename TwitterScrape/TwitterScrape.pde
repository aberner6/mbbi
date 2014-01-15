
//Oauth info
static String OAuthConsumerKey = "YLYsc3WkrUc8zJpidXcnw";
static String OAuthConsumerSecret = "mEwWTHf2nbA01HCysg8llFE9Z3f7lbBsMhbuDVBT6g";

//Access Token info
static String AccessToken = "372054045-7KAICklwZmhsjx6jj7Is7VSIYhXA6Xbu4VxU1JSm";
static String AccessTokenSecret = "h22GG2h0PI0eVaxdIzIl5xLr8659BxzZtmxpXHmXjyKww";

//Filter these keywords
String keywords[] = {
  "brain"
};
String[]txt = new String[3000];


String pieces;



TwitterStream twitter = new TwitterStreamFactory().getInstance();

PFont font;

int index = 0;
//String txt ="";

void setup() {
  size(800, 600);
  noStroke();
  background(0);
  smooth();
  font = loadFont("GeosansLight-24.vlw");

  connectTwitter();
  twitter.addListener(listener);
  twitter.filter(new FilterQuery().track(keywords));
}

void draw() {
frameRate(90);
  fill(0, 1);
  rect(0, 0, width, height);

  //Put it somewhere random on the stage, with a random size and colour
  fill(255, random(50, 150));
  textSize(random(10, 30));

  textFont(font, 24);
  if (index>0) {
    for (int i = 0; i<index; i++) {
      text(txt[index], width/2, index+20);
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
//    for (int i = 0; i<txt.length; i++) {
  ArrayList pieces = new ArrayList();
//        txt= status.getText();

        pieces.add(txt);

//      index++;
//    }
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

