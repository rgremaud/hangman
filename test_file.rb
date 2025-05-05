require 'msgpack'
# msg = MessagePack.pack(obj) # or
obj = [1, 2, 3]
p msg = obj.to_msgpack
# File.binwrite('mydata.msgpack', msg)
