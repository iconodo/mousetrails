// trails.ck
// a training_prototype

// Initialize File I/O
FileIO fout;

// make HidIn and HidMsg
Hid hint;
HidMsg msg;

// which mouse
0 => int device;
// get from command line
if( me.args() ) me.arg(0) => Std.atoi => device;

// open mouse 0, exit on fail
if( !hint.openMouse( device ) ) me.exit();
<<< "mouse '" + hint.name() + "' ready", "" >>>;

// Windowing elements
MAUI_View control_view;
MAUI_Button on_button, training_latch, start_button;
MAUI_Slider pace_note_slider;

// sound chain (mandolin for bass)
Mandolin bass => NRev r => dac;

// contador / counter begins
// 


// default file
//me.sourceDir() + "/cont.txt" => string filename;
me.sourceDir() + "cont.txt" => string filename;

// look at command line
if( me.args() > 0 ) me.arg(0) => filename;

// instantiate
FileIO fio;
FileIO foutright;


// open a file
fio.open( filename, FileIO.READ );

// ensure it's ok
if( !fio.good() )
{
	cherr <= "can't open file: " <= filename <= " for reading..."
	<= IO.newline();
	
	me.exit();
}

// variables to read/write into
int val, val2, quo;
2 => int nonon;

// loop until end
while( fio => val )
{
	cherr <= val <= IO.newline();
	chout <= "el contador es: " <= val <= IO.newline();
	val + 1 => val2;
}


fio.close();

// actualiza / updates the counter number
// to append it to the output "out222...txt" file name

// open for write
foutright.open( filename, FileIO.WRITE );

// test
if( !foutright.good() )
{
	cherr <= "can't open file for writing..." <= IO.newline();
	me.exit();
}

// write some stuff
foutright <= val2 <= IO.newline();
chout <= "el contador queda en: " <= val2 <= IO.newline();

// even odd

val2 / 2 => quo;

if (quo * 2 ==  val2) {
	chout <= "es par: " <= val2 <= IO.newline();
	
	//				return false;
} else {
	1 => nonon;
	chout <= "es impar: " <= val2 <= IO.newline();
	
	//		 		isit = true; 
	
}

// close the thing
foutright.close();

// termina el contador. Counter ends.



// random seed if nonon is 2 == even
//for buttons x,y coordinates always the same
if (nonon == 2) {
	Math.srandom(90); 
}

// data for Frère Jacques tones
[30,41,43,45,46,48,50,51,53,60,63] @=> int scale[]; 

// parameters setup
0.1 => r.mix;
0.0 => bass.stringDamping;
0.02 => bass.stringDetune;
0.05 => bass.bodySize;
.5 => bass.gain;

// variables
1 => int alberto; // counter

0.0 => float cum_x; // mouse movements
0.0 => float cum_y; // from deltX, deltaY

0.0 => float laX2; // deltaX value container

0.0 => float tiem1;// time checking... always
0.0 => float tiem2;


control_view.size( 500, 600 );

on_button.pushType();
on_button.size( 100, 100 );
on_button.position( 0, 0 );
on_button.name( "Yield" );
control_view.addElement( on_button );

pace_note_slider.range( 0.01, 20 );
pace_note_slider.size( 100, pace_note_slider.height() );
pace_note_slider.position( 200, pace_note_slider.y() );
pace_note_slider.value( 15 );
pace_note_slider.name( "Time between notes" );
control_view.addElement( pace_note_slider );


training_latch.pushType();
training_latch.size( on_button.width(), on_button.height() );
training_latch.position( (pace_note_slider.x() + pace_note_slider.width() 
                         + on_button.width()), on_button.y() );
training_latch.name( "Song" );
control_view.addElement( training_latch );


pace_note_slider.value( ) => float pace;

control_view.display();

function void controlMouseMotions() 
{
    
    // infinite event loop
    while( true )
    {
        // wait on HidIn as event
        hint => now;
        
        // messages received
        while( hint.recv( msg ) )
        {
            // mouse motion
			if( msg.isMouseMotion() )
			{
				now / second / 1000 => tiem1;
			   	if( msg.deltaX )
			   	{
			   		msg.deltaX => laX2;
			   		<<< "mouse motion:", msg.deltaX, "on x-axis" >>>;
		   		}
		   		
		   		if( msg.deltaY )
		   		{
		   			now / second / 10000 => tiem2;
		   			<<< "mouse motion:", msg.deltaY, "on y-axis" >>>;
		   			if( tiem2 != tiem1) 
		   			{

		   				cum_x + laX2 => cum_x;
		   				cum_y - msg.deltaY => cum_y;
		   				
		   				fout  <=  laX2 <= "," <= msg.deltaY <= "," 
		   				<= now / second / 1000 <= "," 
		   				<= on_button.name() <= "," <= on_button.x() 
		   				<= "," <= on_button.y() <= ","  <= cum_x 
		   				<= "," <= cum_y <= IO.newline();
	   				}
   				}
		    } 
			
			// mouse button down
			else if( msg.isButtonDown() )
            {
                <<< "mouse button", msg.which, "down" >>>;

            }
            
            // mouse button up
           else if( msg.isButtonUp() )
           {
               <<< "mouse button", msg.which, "up" >>>;
		   }
            
           // mouse wheel motion
           else if( msg.isWheelMotion() )
           {
		   	
		   	    if( msg.deltaX )
		   	    {
		   			<<< "mouse wheel:", msg.deltaX, "on x-axis" >>>;
	   			}
                
				if( msg.deltaY )
				{
					<<< "mouse wheel:", msg.deltaY, "on y-axis" >>>;
				}
			}
        }
    }
}



function void controlNoteOn()
{
    while( true )
    {
        // wait for the button to be pushed down
        on_button => now;
        <<< "note on", on_button.name() >>>;
		<<< "X: ", on_button.x() , "Y: ", on_button.y() >>>;

       //"latch" button has been clicked on label "Training"
       //song notes need to be "clicked"
       if( training_latch.name( ) == "Song") 
	   {
          Math.random2f(0.05,0.5) => bass.pluckPos;
          1 => bass.noteOn;
          0.55 :: second => now;
          1 => bass.noteOff;
          0.05 :: second => now;
       }

       // wait for button to be released
       on_button => now;
       <<< "note off", "" >>>;
    }
}

function void controlLatch()
{
    while( true )
    {
        // wait for button to be pushed down
        training_latch => now;
        <<< "latch on", "" >>>;
        
        if( training_latch.name( ) == "Song") {
            training_latch.name( "Training" );
            pace_note_slider.value(0.05)  => pace;          
        } else {
            training_latch.name( "Song" );
            pace_note_slider.value(4)  => pace;                      
        } 
        
        training_latch => now;
        <<< "latch off", "" >>>;
 
    }
}


function void controlPaceSpeed()
{
    while( true )
    {
        pace_note_slider => now;
        pace_note_slider.value()  => pace;
    }
}


// extended event
class TheEvent extends Event
{
    int value;
}

// the event
TheEvent e;
int x, y;

// handler
fun int hi( TheEvent event )
{
    while( true )
    {
        // wait on event
        event => now;
        // get the data
        <<<e.value>>>;
		// uncomment next 2 code lines to start mouse 
		// tracking from their respective button origin 
		// x,y pair .... and comment next other 2
		
//        Math.random2( 0, 500) => x => cum_x;
//        Math.random2( 100, 600) => y => cum_y;
        Math.random2( 0, 400) => x;
        Math.random2( 100, 500) => y;
        on_button.position( x, y);
    }
}

spork ~ hi( e );
spork ~ controlMouseMotions();
spork ~ controlNoteOn();
spork ~ controlPaceSpeed();
spork ~ controlLatch();



// open file for write
//fout.open( "out222.txt", FileIO.WRITE );
fout.open( "out222" + val2 + ".txt", FileIO.WRITE );

// test
if( !fout.good() )
{
	cherr <= "can't open file for writing..." <= IO.newline();
	me.exit();
}

// starting time
<<< "First now (at second):", now / second >>>;
// file header
fout  <= "dX," <= "dY," <= "WHEN," <= "SYLLABLE," <= "X,"<= "Y,"
      <= "cX,"<= "cY"<=IO.newline();

// infinite time loop
while( true )
{
    // advance time
    // decrase/increase for "difficulty/easiness"
    pace::second => now;

    // set test data
    Math.random2( 0, 1 ) => e.value;
    
    // signal one waiting shred
    e.signal();
    
    // song note matching from scale
    if(alberto == 1 || alberto == 5) {
      on_button.name( "FRAY " + Std.itoa(alberto));
      Std.mtof(scale[1]) => bass.freq;
    }
    
    if(alberto == 2 || alberto == 6) {
        on_button.name( "SAN- " + Std.itoa(alberto));
        Std.mtof(scale[2]) => bass.freq;
    }
    
    if(alberto == 3 || alberto == 7) {
        on_button.name( "-TIA- " + Std.itoa(alberto));
        Std.mtof(scale[3]) => bass.freq;
    }
    
    if(alberto == 4 || alberto == 8) {
        on_button.name( "GO " + Std.itoa(alberto));
        Std.mtof(scale[1]) => bass.freq;
		
    }
    
    if(alberto == 9 || alberto == 12) {
        on_button.name( "¿DUER- " + Std.itoa(alberto));
        Std.mtof(scale[3]) => bass.freq;
    }
    
    if(alberto == 10 || alberto == 13) {
        on_button.name( "-MES " + Std.itoa(alberto));
        Std.mtof(scale[4]) => bass.freq;
    }
    
    if(alberto == 11 || alberto == 14) {
        on_button.name( "TÚ? " + Std.itoa(alberto));
        Std.mtof(scale[5]) => bass.freq;
    }
    
    if(alberto == 15 || alberto == 21) {
        on_button.name( "¡SUE- " + Std.itoa(alberto));
        Std.mtof(scale[5]) => bass.freq;
    }
    
    if(alberto == 16 || alberto == 22) {
        on_button.name( "-NAN " + Std.itoa(alberto));
        Std.mtof(scale[6]) => bass.freq;
    }
    
    if(alberto == 17 || alberto == 23) {
        on_button.name( "LAS " + Std.itoa(alberto));
        Std.mtof(scale[5]) => bass.freq;
    }
    
    if(alberto == 18 || alberto == 24) {
        on_button.name( "CAM- " + Std.itoa(alberto));
        Std.mtof(scale[4]) => bass.freq;
    }
    
    if(alberto == 19 || alberto == 25) {
        on_button.name( "-PA- " + Std.itoa(alberto));
        Std.mtof(scale[3]) => bass.freq;
    }
    
    if(alberto == 20 || alberto == 26 ) {
        on_button.name( "-NAS! " + Std.itoa(alberto));
        Std.mtof(scale[1]) => bass.freq;
    }
   
    if(alberto == 27 || alberto == 30 ) {
       on_button.name( "¡DIN! " + Std.itoa(alberto));
       Std.mtof(scale[2]) => bass.freq;
    }
    
    if(alberto == 28 || alberto == 31 ) {
       on_button.name( "¡DAN! " + Std.itoa(alberto));
       Std.mtof(scale[5]-12) => bass.freq;
    }
    
    if(alberto == 29 || alberto == 32 ) {
       on_button.name( "¡DON! " + Std.itoa(alberto));
       Std.mtof(scale[1]) => bass.freq;
    }
 
    //"latch" button has been clicked on label "song"
    //notes need not to be "clicked"
    if( training_latch.name( ) == "Training") {
		Math.random2f(0.05,0.5) => bass.pluckPos;
		1 => bass.noteOn;
		0.55 :: second => now;
		1 => bass.noteOff;
		0.05 :: second => now;
     }

    alberto + 1 => alberto;

	// uncomment next line for song entirety
//    if( alberto > 33) 
    // uncomment next line for one song phrase length
//    if( alberto > 5) 
    if( alberto > 9) // first song phrase repeated
    {
		<<< "Last now (at second):", now / second >>>;
		// close file
		// COMMENT next 2 lines if all song samples wanted
		fout.close();
		me.exit();
		// and UNcomment below...
	}
	

    // uncomment next line for full training and comment next
//	if( alberto > 33) // song entirety
	if( alberto > 9) // 1st phrase of song, repeated 		
	{
		<<< "Last now (at second):", now / second >>>;
		// close file
		// UNcomment next 2 lines if all song samples wanted
		//fout.close();
		//me.exit();
		
		// AND COMMENT SAME LINES IN PREVIOUS if clause
	}

}


