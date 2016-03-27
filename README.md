# MRIplus #


### Autonomous Tissue abnormality detection system ###

### Approach ###

1. Divide the image into tiles of nxn (n=8 or 16)
2. If a tile includes an edge of the tumor brain skip those
3. Normalize the tiles remove effects of intensity
4. Label the tiles with tumor regions edge=1 and rest=0 (Only when training)
5. Train the model with labeled tiles
6. Test against the test set

### Tile breakdown ###
![alt text](http://s14.postimg.org/jkpww928x/Screen_Shot_2016_03_27_at_9_50_58_PM.png)

### Architecture ###

![alt text](http://s8.postimg.org/nbuzg2n91/Screen_Shot_2016_03_27_at_9_42_01_PM.png)

### User roles ###

| Role        | Task           |
| ------------- |:-------------:|
|Anonymous user|Anonymous users can use the system to classify their images after there have been verified as humans.|
|Unvalidated user|Anonymous users become Unvalidated users after they have signed up with the system and there have all the privileges that anonymous users have. In addition to that the Unvalidated user will be able to upload new training data sets to the system queue.|
|Validated user|Validated user will have all the privileges that both anonymous users and Unvalidated users had as well as the will be able to verify the training data set which have uploaded by the unvalidated users.|
|Admin|Admin will have all the privileges to make a unvalidated user a validated user and the other way around as well as make admins from validated users.|

slides: https://goo.gl/mjj7nr
