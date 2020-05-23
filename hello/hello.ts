import { serve } from "https://deno.land/std@0.52.0/http/server.ts";
  const srv = serve({ port: 8000 });
  console.log("Listening on http://localhost:8000/");
  var i:number = 0;
  for await (const req of srv) {
    ++i;
    req.respond({ body: "Hello World "+i+"\n"});
    console.log("Hello World "+i);
  }

