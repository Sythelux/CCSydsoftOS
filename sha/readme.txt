***Sha1 and BigInt libraries for Lua***

I have created these libraries for one of my WoW addon projects for which
I needed digital signatures. Feel free to use them in your own code.

You can run tests with Test.lua, all you need is the Lua interpreter from
http://luabinaries.luaforge.net/. Use dofile("Test.lua") to run the code.

This is implemented in pure Lua. If you have access to C crypto libraries,
use those instead since they are a thousand times faster!

Martin Huesser
www.lenja.ch