@:put('/thumbnail')
function uploadThumbnail(/* body:RealSource */):Promise<OutgoingResponse>;

@:get
function image():Promise<OutgoingResponse>;
