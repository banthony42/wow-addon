# World of Warcraft Addons
This repo hold my World of Warcraft home made addons

## Maquereau
I'm playing World of Warcraft in Hardcore mode.
Since i die quite often, i need to create my macros again and again in the characater tab. I know is the purpose of the "General" tab to keep macro globally and therefore i could retrieve them between each characters.
But the more class you play, the more the mess will come !
<br>
That's why i've wrote `Maquereau`.

### Example
During my character journey, each time i build a new macro, i can save them in an internal Library, using this command:
```
/maquereau rm lib
/maquereau save
```

Macro are saved and retrieved according to the class you are playing.

Run 1:
- start a Rogue
- save the rogue built macros
- die with your rogue

Run 2:
- try a shaman
- save the shaman built macros
- die with your shaman

Run 3:
- retry with a rogue

In the Run 3, you may want to retrieve all macros built in Run1,
then you just need to run this command:

```
/maquereau load
```

### Usage 

```
Maquereau help you keeping track of you class macros:
/maquereau or /mq CMD

CMD:
help : Display this message.
save : Save all macro from this character, for the class you are playing in your lib.
load : Load all macro from your lib, in your character macro tab.
show : Show saved macros in your lib.
rm lib: Delete all saved macros in your lib.
rm global : Delete all global macros.
rm char : Delete all character macros.
```

## Legacy
This folder hold old versions of addons, kept here for conveniency,to quicly consult the code when needed.