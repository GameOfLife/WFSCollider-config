(
~iphone = NetAddr("192.168.1.82",57130);

//state vars;			
			
~currentSelected = 0;
~responders = List.new;

//initial positions:
//page 1
~iphone.sendMsg('/1/xy',0.5,0.5);
8.do{ |x| ~iphone.sendMsg(("/1/selectSource/"++(x+1)++"/1").asSymbol, (x == 0).binaryValue) };
//page 2
8.do{ |x| ~iphone.sendMsg(("/2/levels/"++(x+1)).asSymbol, 1) };
8.do{ |x| ~iphone.sendMsg(("/2/on"++x).asSymbol, 1) };
8.do{ |x| ~iphone.sendMsg(("/2/type"++x).asSymbol, 1) };
//page3
~iphone.sendMsg('/3/mainLevel',0.5);
~iphone.sendMsg('/3/onOff',0);

//responders:

//page 1
~responders.add(OSCresponder(nil,'/1/xy',{ |t, r, msg|
	msg.postln;
	WFSLive.tracks[~currentSelected].pos_((msg[1].linlin(0.0,1.0,-15.0,15.0)@(msg[2].linlin(0.0,1.0,15.0,-15.0))));		
}).add);
8.do{ |x| 
~responders.add(OSCresponder(nil,("/1/selectSource/"++(x+1)++"/1").asSymbol,{ |t, r, msg|
	var pos;
	msg.postln;
	if(msg[1]==1){
		
		8.do{ |y| if(y!=x){ ~iphone.sendMsg(("/1/selectSource/"++(y+1)++"/1").asSymbol,0)} };
		~currentSelected=x;
		pos = WFSLive.tracks[~currentSelected].pos;
		~iphone.sendMsg('/1/xy',pos.x.linlin(-15.0,15.0,0.0,1.0),pos.y.linlin(-15.0,15.0,1.0,0.0));		
	};
}).add)
};

//page 2
8.do{ |x| 
	~responders.add(OSCresponder(nil,("/2/levels/"++(x+1)).asSymbol,{ |t, r, msg|
	msg.postln;
	WFSLive.tracks[x].level_( msg[1].clip(0.0,1.0) )}).add)
};
8.do{ |x|
~responders.add(OSCresponder(nil,("/2/on"++x).asSymbol,{ |t, r, msg|
	msg.postln;
	WFSLive.tracks[x].isRunning_( msg[1].booleanValue )
}).add)	
};
8.do{ |x|
~responders.add(OSCresponder(nil,("/2/type"++x).asSymbol,{ |t, r, msg|
	msg.postln;
	WFSLive.tracks[x].type_( if(msg[1]==0){\plane}{\point} )
}).add)	
};
//page3
~responders.add(OSCresponder(nil,'/3/mainLevel',{ |t, r, msg|
	msg.postln;
	WFSLevelBus.setRaw(WFSLevelBus.dbToRaw(msg[1].linlin(0.0,1.0,-60,-6)),updateWindow:true);
}).add);
~responders.add(OSCresponder(nil,'/3/onOff',{ |t, r, msg|
	msg.postln;
	if(msg[1]==0){
		"s".postln;
		WFSLive.stop;
		WFSLive.changed(\end)
	}{
		"start".postln;
		WFSLive.start;
		WFSLive.changed(\start)
	};
}).add);

)

~responder.do(_.remove);