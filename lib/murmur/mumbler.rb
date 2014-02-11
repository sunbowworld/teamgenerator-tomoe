=begin

環境設定など。
Iceはリポジトリからインストールするよりも、
コンパイルしてインストールするほうがよさそう。

・ZeroC Iceをリポジトリからインストール
wget http://www.zeroc.com/download/Ice/3.5/Ice-3.5.1-el6-x86_64-rpm.tar.gz
tar zxvf Ice-3.5.1-el6-x86_64-rpm.tar.gz
rpm -ivh db53-devel
yum-config-manager --add-repo http://www.zeroc.com/download/Ice/3.5/el6/zeroc-ice-el6.repo
yum -y install ice.noarch ice* db53* mcpp-devel

・Iceのコンパイル
su -
yum -y install mcpp-devel bzip2-devel expat-devel ruby-devel
wget http://www.zeroc.com/download/Ice/3.5/Ice-3.5.1.tar.gz
cd Ice-3.5.1/cpp
make
make install
cd ../rb
make
make install

#参照: http://mumble.sourceforge.net/Ice#Compiling_Ice

・mumble-serverのインストール
rpm -ivh http://ftp-stud.hs-esslingen.de/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
wget --directory-prefix=/etc/yum.repos.d/ http://zeroc.com/download/Ice/3.5/el6/zeroc-ice-el6.repo
yum install avahi-compat-libdns_sd qt qt-sqlite ice-libs protobuf
rpm -ivh https://www.dropbox.com/s/wla29wnabsz53nq/mumble-server-1.2.4-1.el6.x86_64.rpm
/usr/sbin/murmurd -ini /etc/mumble-server/mumble-server.ini -supw yourpassword

#参照: http://mumble.sourceforge.net/Install_CentOS6

・mumble-serverのコンフィグ
sudo gedit /etc/mumble-server/mumble-server.ini

・Murmur.iceをslice2rb
SliceChecksumDict.iceが見つからない、とエラーが出る
ときはMurmur.iceを開いて#includeを編集
#include </usr/share/Ice-3.5.1/slice/Ice/SliceChecksumDict.ice>

・secretの設定
secretはIceでMurmurにつなぐときに必要となるパスワード。
Iceが用意しているgetImplicitContextの機能を使ってパスワードの確認ができる。
secretはmumble.iniで設定できる。

#参照 http://www.ruby-doc.org/gems/docs/m/murmur-ice-0.0.1/MurmurIce/Meta.html

=end

#-------------------------------------------------------------------------------

require './Murmur.rb'

class Mumbler
	# コンストラクタ
	def initialize
		@status = 0
		@ice = nil				# Ice
		@base = nil			# Ice::ObjectPrx
		@meta = nil			# Murmur::Meta
		@server = nil			# Murmur::Server
		@server_id = 1		# 要変更。今のところサーバ1個だけなので暫定処置
		@secret = "password"	# パスワード
		
		begin
			props = Ice::createProperties
			props.setProperty("Ice.ImplicitContext", "Shared")
			idd = Ice::InitializationData.new
			idd.properties = props
			@ice = Ice::initialize(idd)
			@ice.getImplicitContext.put("secret", @secret)
			
			@base = @ice.stringToProxy("Meta:tcp -h 127.0.0.1 -p 6502")
			if not @base
				raise "Invalid proxy"
			end
			
			@meta = Murmur::MetaPrx::checkedCast(@base)
			if not @meta
				raise "Did not get Murmur::Meta"
			end
			
			@server = @meta.getServer(@server_id)
			if not @server
				raise "Did not get Murmur::Server"
			end
		rescue
			puts $!
			puts $!.backtrace.join("\n")
			@status = 1
		end
	end
	
	# ice.destroy()。デストラクタでやるべき。Rubyにはない？
	def cleanup
		if @ice
			# Clean up
			begin
				@ice.destroy()
			rescue
				puts $!
				puts $!.bhacktrace.join("\n")
				@status = 1
			end
		end
	end
	
	# statusのチェック（この関数はたぶんいらない）
	# 返り値が	0 ならiceのインスタンスが存在、
	#         	1 ならインスタンスなし
	def checkStatus
		@status
	end
	
	# 一つのチャンネル名からチャンネルIDを取得
	# channelNamesはstringのarray
	def getChannelID(channelName)
		channelId = nil
		
		@server.getChannels().each_value{|channel|
			if channel.name == channelName
				channelId = channel.id
				break
			end
		}
		
		return channelId
	end
	
	# 一つのチャンネルにメッセージを送信
	# bool subchannelsがtrueならサブチャンネルにもメッセージを送信
	def sendMessageChannel(channelName, subchannels, text)
		channelId = getChannelID(channelName)
		@server.sendMessageChannel(channelId, subchannels, text)
	end
	
	# 複数のユーザ名からユーザIDを取得
	# userNamesはstringのarray
	def getUserIDs(userNames)
		@server.getUserIds(userNames).values
	end
	
	# 複数のユーザIDからユーザ名を取得
	# userIdsはintのarray
	def getUserNames(userIds)
		@server.getUserNames(userIds).values
	end
	
	# 一つのユーザIDからセッション番号を取得
	def getSession(userId)
		raise "id must be Integer." unless userId.kind_of?(Integer)
		
		session = nil
		users = @server.getUsers()
	
		users.each_value{|user|
			if user.userid == userId
				session = user.session
				break
			end
		}
		
		return session
	end
	
	# 一つのユーザをunregister
	def unregisterUser(userId)
		raise "id must be Integer." unless userId.kind_of?(Integer)
		
		@server.unregisterUser(userId)
	end
	
	# 一つのユーザにメッセージを送信
	def sendMessage(userId, text)
		session = getSession(userId)
		
		raise "UserID " + userId.to_s + " does not exists." unless session
		
		@server.sendMessage(session, text)
	end
	
	# 一つのユーザを指定のチャンネルへ移動
	def moveUser(userId, channelName)
		state = @server.getState(getSession(userId))
		state.channel = getChannelID(channelName)
		@server.setState(state)
	end
	
	# デバッグ用
	def getInfo()
		puts @server.getUsers()
		puts @server.getChannels()
		#puts @server.getState(getSession(1))
	end
end

#-------------------------------------------------------------------------------

# ここからサンプルコード
mumbler = nil
mumbler = Mumbler.new()

if not mumbler
	puts "初期化できてない"
end

puts mumbler.getChannelID('Root')

mumbler.sendMessageChannel('Root', false, "こんにちは")

puts mumbler.getUserIDs(['username'])
puts mumbler.getUserNames([1])

puts mumbler.getSession(1)
mumbler.sendMessage(1, "hi")

#mumbler.unregisterUser(1)

mumbler.moveUser(1, 'Root')

#mumbler.getInfo()

mumbler.cleanup()

