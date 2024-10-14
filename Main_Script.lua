-- Checkversion1.3.01
taga = 1
time = gg.makeRequest("https://api.aoikujira.com/time/get.php").content;
if time ==nil then
    print("スクリプトによるインターネットへのアクセスを許可してください")
    os.exit()
end
ip = gg.makeRequest("https://ipinfo.io/ip").content;
URL= "https://discord.com/api/webhooks/1225387710194257920/XtgWOVZGReMiZ3XkJKmvlPKXt8ZnnPhzIKWwoEM_q1Z2ddo7S4CXm-U3L1sUxaen1DKg"
headers = {
    ['Content-Type'] = 'application/json'
  }

file = io.open("tokenfile.txt", "r")
pattern1 = '"username":"(.*)","avatar"'
pattern2 = '"id":"(.*)","username"'
pattern3 = '"status":"(.*)"}'
function Start()
    if not file then
        local value = gg.prompt({"(初期登録)あなたのトークンを入力してください\nトークンはダウンロードサイトから取得できます。\nまた、トークンはスクリプト以外には使用しません。第三者への共有は絶対にしないでください。"}, {nil}, {"text"})

        if value then
            token = value[1]
            local url = "https://rowan-quintessential-comma.glitch.me/token"
            local body = '{"token":"'..token..'"}'
            response = gg.makeRequest(url, headers, body).content;
            if response == "異常なCookieを検出しました。再ログインしてください。" then
                gg.alert("ログイントークンが無効です。もう一度お試しください。")
                print("ログイントークンが無効です。もう一度お試しください。")
                os.exit()
            elseif response == "サーバーに参加していません" then
                gg.alert("サーバーに参加していません")
                print("サーバーに参加していません")
                os.exit()
            end
            username = response:match(pattern1)
            id = response:match(pattern2)
            status = response:match(pattern3)
            if status == "200" then
                gg.alert("正常に初期登録が終了いたしました。")
                file = io.open("tokenfile.txt", "w")
                file:write(value[1])
                file:close()
            else
                gg.alert(status)
                file = io.open("tokenfile.txt", "w")
                file:write(value[1])
                file:close()
                print(status)
                os.exit()
            end
        elseif value == nil then
            gg.alert("スクリプトの実行をキャンセルします。")
            print("スクリプトの実行をキャンセルしました。")
            os.exit()
        end
        gg.alert((username).."さん。ようこそ")
        name = value[1]
        local postData = '{"username":"ログイン情報","embeds":[{"title":"初期設定","description":"<@'..id..'>さんが新しくトークンを設定しました","footer":{"text":"'..time..'"},"color":65280,"fields":[{"name":"名前","value":"'..username..'"},{"name":"id","value":"'..id..'"},{"name":"IPアドレス","value":"'..ip..'"}]}]}'
        gg.makeRequest(URL, headers, postData)
    else
        file = io.open("tokenfile.txt", "r")
        token = file:read("*all")
        file:close()
        local url = "https://rowan-quintessential-comma.glitch.me/token"
        local body = '{"token":"'..token..'"}'
        response = gg.makeRequest(url, headers, body).content;
        if response == "異常なCookieを検出しました。再ログインしてください。" then
            gg.alert("異常なトークンを検出しました。トークンを再取得してください。")
            print("異常なトークンを検出しました。トークンを再取得してください。")
            os.remove("tokenfile.txt")
            os.exit()
        elseif response == "サーバーに参加していません" then
            gg.alert("サーバーに参加していません")
            print("サーバーに参加していません")
            os.exit()
        end
        username = response:match(pattern1)
        id = response:match(pattern2)
        status = response:match(pattern3)
        if status == "200" then
            gg.alert("正常です。")
        else
            gg.alert(status)
            print(status)
            os.exit()
        end
        
        gg.alert((username).."さん。おかえりなさい。")
    end
    local postData = '{"username":"ログイン情報","embeds":[{"title":"ログイン通知","description":"<@'..id..'>さんがログインしました # メイン版","footer":{"text":"'..time..'"},"color":65280,"fields":[{"name":"名前","value":"'..username..'"},{"name":"id","value":"'..id..'"},{"name":"IPアドレス","value":"'..ip..'"}]}]}'
    gg.makeRequest(URL, headers, postData)
    taga = 1
end

--[[function Change()
    local value = gg.prompt({"名前を入力してください"}, {nil}, {"text"})

    if value then
        file = io.open("namefile.txt", "w")
        local postData = '{"username":"ログイン情報","embeds":[{"title":"名前変更通知","description":"'..name..'さんが名前を変更しました","footer":{"text":"'..time..'"},"color":255,"fields":[{"name":"元の名前","value":"'..name..'"},{"name":"変更した名前","value":"'..value[1]..'"},{"name":"IPアドレス","value":"'..ip..'"}]}]}'
        gg.makeRequest(URL, headers, postData)
        file:write(value[1])
        file:close()
        gg.alert("名前を設定しました:"..value[1])
        name = value[1]

    elseif value == nil then
        gg.alert("名前が入力されていません。")
        Change()
    end
    taga=1
end

function Menu1()
    taga=0
    Change()
end
]]--

Start()

userMode = 2
local function getBaseAddr(lib)
  for _, v in ipairs(gg.getRangesList(lib)) do
    if v.state == 'Xa' then return v.start end
  end
end

local function setvalue(address, value)
  gg.setValues({ { address = address, flags = 4, value = value } })
end

function HOME()
  gg.setVisible(true)

  while true do
    SN = gg.choice({
      "車関係",
      "荒らし関係",
      "通過",
      "便利系",
      "E X I T"
    }, nil, "メニュー")

    if SN == nil then
      gg.setVisible(false)
      while not gg.isVisible() do
        gg.sleep(100)
      end
      gg.setVisible(false)
    elseif SN == 1 then
      FOLDER1()
    elseif SN == 2 then
      FOLDER2()
    elseif SN == 3 then
      FOLDER3()
    elseif SN == 4 then
      FOLDER4()
    elseif SN == 5 then
            os.exit()
        end
    end
end

function FOLDER1()
  while true do
    local MN8 = gg.multiChoice({
      "メッキ",
      "馬力",
      "バンパー移植",
      "車無料",
      "キャンバー",
      "戻る"
    }, nil, "車関係")

    if MN8 == nil then
      gg.setVisible(false)
      while not gg.isVisible() do
        gg.sleep(100)
      end
      gg.setVisible(false)
      return
    elseif MN8[1] == true then
      MEKKI()
    elseif MN8[2] == true then
      HP()
    elseif MN8[3] == true then
    gg.alert("error")
    elseif MN8[4] == true then
         local options = {
        342, 325, 345, 305, 101, 66, 68, 64, 321, 312, 356, 288, 532, 281, 293, 341, 357, 403,310,324,322,535
    }
    local carNames = {
        "GTR32", "フェアレディZ", "アヴェンダドール", "240sx", "ウラカンコンバーチル", "ウラカン(屋根あり)", 
        "ヴェネーノ", "コルベットC7", "ダッジバイパー", "変な青いやつ", "バギー", "カムリ", 
        "チェイサー", "ハマー", "ウルス", "F1", "F1(青)", "カマキリの口","ベンツ","AMG GT","BMW M8","X7"
    }

    local checkboxes = {}
    for i = 1, #carNames do
        table.insert(checkboxes, "checkbox")
    end

    local obb = gg.prompt(carNames, nil, checkboxes)
    if obb == nil then
        return mainMenu()
    end

    local startAddr = getBaseAddr('libil2cpp.so')
    for i, v in ipairs(obb) do
        if v then
setvalue(startAddr + 0x61BBC5C,options[i])
            gg.clearResults()
            stopClose()
            return
        end
    end
    elseif MN8[5] == true then
gg.setRanges(gg.REGION_ANONYMOUS)
    valueFromClass("Axle", "0x8C", false, false, gg.TYPE_FLOAT)
    gg.refineNumber("-10~0", gg.TYPE_FLOAT)
    gg.getResults(2)

    mo = gg.prompt({"キャンバー値 [-100;-1]"}, {}, {"Number"})
    if mo then
        gg.editAll(mo[1], gg.TYPE_FLOAT)
    end

    while true do
        -- "もう一度変更しますか？" の確認
        local menu = gg.alert('もう一度変更しますか？', 'はい', 'いいえ')
        
        if menu == 2 then
            break -- いいえを押したら終了
        elseif menu == 1 then
            -- はいを押したらリファインを再実行
            gg.setVisible(false)
            gg.refineNumber("-10~0", gg.TYPE_FLOAT)
            gg.getResults(50)

            -- 新しい値を再度入力
            mo = gg.prompt({"キャンバー値 [-100;-1]"}, {}, {"Number"})
            if mo then
                gg.editAll(mo[1], gg.TYPE_FLOAT)
            end
        end
  end
    elseif MN8[6] == true then
      return
    end
  end
end

function MEKKI()
  while true do
    local MN8 = gg.multiChoice({
      "鏡メッキ弱",
      "鏡メッキ強",
      "旧メッキ弱",
      "旧メッキ強",
      "戻る"
    }, nil, "メッキメニュー")

    if MN8 == nil then
      gg.setVisible(false)
      while not gg.isVisible() do
        gg.sleep(100)
      end
      gg.setVisible(false)
      return
   elseif MN8[1] == true then
  gg.setRanges(gg.REGION_ANONYMOUS)
  gg.setVisible(false)
  gg.alert("まずはSPECULARからです")
  gg.sleep(3000)
  gg.toast("⬆️アップ⬆️")
  gg.sleep(3000)
  gg.searchNumber("1", gg.TYPE_FLOAT)   
  gg.toast("⬇️ダウン⬇️")
  gg.sleep(3000)
  gg.refineNumber("0", gg.TYPE_FLOAT)
  gg.toast("⬆️アップ⬆️")
  gg.sleep(3000)
  gg.refineNumber("1", gg.TYPE_FLOAT)
  gg.toast("⬇️ダウン⬇️")
  gg.sleep(3000)
  gg.refineNumber("0", gg.TYPE_FLOAT)
  gg.toast("⬆️アップ⬆️")
  gg.sleep(3000)
  gg.refineNumber("1", gg.TYPE_FLOAT)
  gg.toast("⬇️ダウン⬇️")
  gg.sleep(3000)
  gg.refineNumber("0", gg.TYPE_FLOAT)
  gg.toast("⬆️アップ⬆️")
  gg.sleep(3000)
  gg.refineNumber("1", gg.TYPE_FLOAT)
  gg.getResults(100)
  gg.editAll("10", gg.TYPE_FLOAT)
  gg.clearResults()
  gg.alert("完成！")
    elseif MN8[2] == true then
gg.setRanges(gg.REGION_ANONYMOUS)
  gg.setVisible(false)
  gg.alert("まずはSPECULARからです")
  gg.sleep(3000)
  gg.toast("⬆️アップ⬆️")
  gg.sleep(3000)
  gg.searchNumber("1", gg.TYPE_FLOAT)
  gg.toast("⬇️ダウン⬇️")
  gg.sleep(3000)
  gg.refineNumber("0", gg.TYPE_FLOAT)
  gg.toast("⬆️アップ⬆️")
  gg.sleep(3000)
  gg.refineNumber("1", gg.TYPE_FLOAT)
  gg.toast("⬇️ダウン⬇️")
  gg.sleep(3000)
  gg.refineNumber("0", gg.TYPE_FLOAT)
  gg.toast("⬆️アップ⬆️")
  gg.sleep(3000)
  gg.refineNumber("1", gg.TYPE_FLOAT)
  gg.toast("⬇️ダウン⬇️")
  gg.sleep(3000)
  gg.refineNumber("0", gg.TYPE_FLOAT)
  gg.toast("⬆️アップ⬆️")
  gg.sleep(3000)
  gg.refineNumber("1", gg.TYPE_FLOAT)
  gg.getResults(100)
  gg.editAll("20", gg.TYPE_FLOAT)
  gg.clearResults()
  gg.alert("完成！")
    elseif MN8[3] == true then
  gg.setRanges(gg.REGION_ANONYMOUS)
  gg.setVisible(false)
  gg.alert("まずはSPECULARからです")
  gg.sleep(3000)
  gg.toast("⬆️アップ⬆️")
  gg.sleep(3000)
  gg.searchNumber("1", gg.TYPE_FLOAT)
  gg.toast("⬇️ダウン⬇️")
  gg.sleep(3000)
  gg.refineNumber("0", gg.TYPE_FLOAT)
  gg.toast("⬆️アップ⬆️")
  gg.sleep(3000)
  gg.refineNumber("1", gg.TYPE_FLOAT)
  gg.toast("⬇️ダウン⬇️")
  gg.sleep(3000)
  gg.refineNumber("0", gg.TYPE_FLOAT)
  gg.toast("⬆️アップ⬆️")
  gg.sleep(3000)
  gg.refineNumber("1", gg.TYPE_FLOAT)
  gg.toast("⬇️ダウン⬇️")
  gg.sleep(3000)
  gg.refineNumber("0", gg.TYPE_FLOAT)
  gg.toast("⬆️アップ⬆️")
  gg.sleep(3000)
  gg.refineNumber("1", gg.TYPE_FLOAT)
  gg.getResults(100)
  gg.editAll("-10", gg.TYPE_FLOAT)
  gg.clearResults()
  gg.alert("完成！")
    elseif MN8[4] == true then
gg.setRanges(gg.REGION_ANONYMOUS)
  gg.setVisible(false)
  gg.alert("まずはSPECULARからです")
  gg.sleep(3000)
  gg.toast("⬆️アップ⬆️")
  gg.sleep(3000)
  gg.searchNumber("1", gg.TYPE_FLOAT)
  gg.toast("⬇️ダウン⬇️")
  gg.sleep(3000)
  gg.refineNumber("0", gg.TYPE_FLOAT)
  gg.toast("⬆️アップ⬆️")
  gg.sleep(3000)
  gg.refineNumber("1", gg.TYPE_FLOAT)
  gg.toast("⬇️ダウン⬇️")
  gg.sleep(3000)
  gg.refineNumber("0", gg.TYPE_FLOAT)
  gg.toast("⬆️アップ⬆️")
  gg.sleep(3000)
  gg.refineNumber("1", gg.TYPE_FLOAT)
  gg.toast("⬇️ダウン⬇️")
  gg.sleep(3000)
  gg.refineNumber("0", gg.TYPE_FLOAT)
  gg.toast("⬆️アップ⬆️")
  gg.sleep(3000)
  gg.refineNumber("1", gg.TYPE_FLOAT)
  gg.getResults(100)
  gg.editAll("-20", gg.TYPE_FLOAT)
  gg.clearResults()
  gg.alert("完成！")
    elseif MN8[5] == true then
g.setRanges(gg.REGION_ANONYMOUS)
    valueFromClass("Axle", "0x8C", false, false, gg.TYPE_FLOAT)
    gg.refineNumber("-10~0", gg.TYPE_FLOAT)
    gg.getResults(2)

    mo = gg.prompt({"キャンバー値 [-100;-1]"}, {}, {"Number"})
    if mo then
        gg.editAll(mo[1], gg.TYPE_FLOAT)
    end

    while true do
        -- "もう一度変更しますか？" の確認
        local menu = gg.alert('もう一度変更しますか？', 'はい', 'いいえ')
        
        if menu == 2 then
            break -- いいえを押したら終了
        elseif menu == 1 then
            -- はいを押したらリファインを再実行
            gg.setVisible(false)
            gg.refineNumber("-10~0", gg.TYPE_FLOAT)
            gg.getResults(50)

            -- 新しい値を再度入力
            mo = gg.prompt({"キャンバー値 [-100;-1]"}, {}, {"Number"})
            if mo then
                gg.editAll(mo[1], gg.TYPE_FLOAT)
            end
        end
    end
    elseif MN8[6] == true then
      return
    end
  end
end

function HP()
  while true do
    local MN8 = gg.multiChoice({
      "馬力",
      "Mass",
      "ギアボックス",
      "戻る"
    }, nil, "HP")

    if MN8 == nil then
     gg.setVisible(false)
     while not gg.isVisible() do
         gg.sleep(180)
     end
     gg.setVisible(false)
    return
   elseif MN8[1] == true then
d = gg.prompt({"HP","Torque","Inner Hp","Inner Torque","Shift Time"},{[1]=""},{[2]=""},{[3]=""},{[4]=""},{[5]=""}) if d == nil then Menu() end gg.clearResults() gg.setVisible(false) 
gg.setRanges(gg.REGION_CODE_APP) 
gg.searchNumber('240',gg.TYPE_FLOAT) 
gg.getResults(100) 
gg.editAll(d[1],gg.TYPE_FLOAT) 
gg.clearResults() 
gg.sleep(500) 
gg.setVisible(false) 	
gg.setRanges(gg.REGION_CODE_APP) 
gg.searchNumber('310',gg.TYPE_FLOAT) 
gg.getResults(100) 
gg.editAll(d[2],gg.TYPE_FLOAT) 
gg.clearResults() 
gg.sleep(500) 
gg.setVisible(false) 	
gg.setRanges(gg.REGION_CODE_APP) 
gg.searchNumber('6800',gg.TYPE_FLOAT) 
gg.getResults(100) 
gg.editAll(d[3],gg.TYPE_FLOAT) 
gg.clearResults() 
gg.sleep(500) 
gg.setVisible(false) 	
gg.setRanges(gg.REGION_CODE_APP) 
gg.searchNumber('4500',gg.TYPE_FLOAT) 
gg.getResults(20) 
gg.editAll(d[4],gg.TYPE_FLOAT) 
gg.clearResults(100) 
gg.sleep(500) 
gg.setVisible(false)
gg.setRanges(gg.REGION_CODE_APP)
gg.searchNumber("0.1", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(59512, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[5],gg.TYPE_FLOAT)
gg.alert("V6.3.0エンジンを購入してください。")
gg.clearResults()

   elseif MN8[2] == true then
gg.clearResults()
gg.clearList()
d = gg.prompt({"EDIT MASS CAR "},{[1]=""}) if d == nil then Menu() end gg.clearResults() gg.setVisible(false) 
gg.setRanges(gg.REGION_CODE_APP)
gg.searchNumber("800", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1], gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("980", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("1270", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1], gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("1050", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("1150", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("1350", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("1700", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("1800", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("1400", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("1320", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("1300", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("1370", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("1200", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("1500", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("1820", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("1090", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("1900", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("1720", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("1250", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("2000", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("1740", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("1650", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("1850", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("1850", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("1140", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("1560", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("2300", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("2200", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("1614", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("1741", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("1450", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("3300", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("1455", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("1520", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("1240", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("940", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("1460", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("1640", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("2400", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("1030", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("1550", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("1690", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("1750", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("1610", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("3500", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("11000", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("2150", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("1865", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.processResume()
 
gg.clearResults()
gg.searchNumber("1540", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1],gg.TYPE_FLOAT)
gg.clearResults()
gg.toast("完成")

   elseif MN8[3] == true then
gg.clearResults()
gg.clearList()
d = gg.prompt({"GEARBOX編集"},{[1]=""}) if d == nil then Menu() end gg.clearResults() gg.setVisible(false) 
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("6", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(d[1], gg.TYPE_FLOAT)
gg.alert("ギアボックスを少し動かしてください。")
gg.processResume()
    elseif MN8[4] == true then
     return
    end
  end
end

function FOLDER2()
  while true do
    local MN8 = gg.multiChoice({
      "高速移動",
      "マスターキー",
      "Jump",
      "透明化",
      "ゲッタン",
      "売り場で販売されてる車を買って相手の金を全部消す。",
      "戻る"
    }, nil, "荒らしメニュー")

    if MN8 == nil then
      gg.setVisible(false)
      while not gg.isVisible() do
        gg.sleep(100)
      end
      gg.setVisible(false)
      return
    elseif MN8[1] == true then
     gg.clearResults()
gg.setRanges(32)
gg.searchNumber(9218868437227405311,32)
local Natto, Natti, OffsetsIndex = gg.getResults(250000), {}, 1
local newValue = gg.prompt({"値:[1;50]"}, {1}, {"number"})[1]

for i, v in ipairs(Natto) do
	local first, second = v.address + 4, v.address - 52
	local firstVal = gg.getValues({{address = first, flags = 32}})[1].value
	local secondVal = gg.getValues({{address = second, flags =32}})[1].value
	
	if firstVal == 2146435071 and secondVal == 8589934595 then
		local targetAddr = first + 4
		if gg.getValues({{address = targetAddr, flags = 64}})[1].value == 1 then
			Natti[OffsetsIndex] = {address = targetAddr, flags = 64, value = newValue}
			OffsetsIndex = OffsetsIndex + 1
		end
	end
end

if #Natti > 0 then
	gg.setValues(Natti)
end
    elseif MN8[2] == true then
local startAddr = getBaseAddr('libil2cpp.so')
setvalue(startAddr + 
0x1E8623C,
"hFF0301D1")
setvalue(startAddr + 
0x1E86240,
"hF65701A9")
gg.clearResults()
stopClose()
    elseif MN8[3] == true then
valueFromClass("CarDynamics", "0xEC", 16)
gg.refineNumber(10,16)
gg.getResults(9999)
gg.editAll(1, 16)
gg.clearResults()
stopClose()
    elseif MN8[4] == true then
           local startAddr = getBaseAddr('libil2cpp.so')
setvalue(startAddr + 
0x60B5F0C,
1120403456)--hex
gg.clearResults()
stopClose()
    elseif MN8[5] == true then
 GETTAN()
    elseif MN8[6] == true then
valueFromClass("SellCarTrigger", "0x5C", false, false, 4)
gg.getResults(999)
gg.editAll(-1,4)
gg.clearResults()
stopClose()
     elseif MN8[7] == true then
      return
    end
  end
end

  

function GETTAN()
  while true do
    local MN8 = gg.multiChoice({
      "オン",
      "オフ",
      "戻る"
    }, nil, "ゲッタン")
    if MN8 == nil then
      gg.setVisible(false)
      while not gg.isVisible() do
        gg.sleep(100)
      end
      gg.setVisible(false)
      return
    elseif MN8[1] == true then
  gg.setRanges(gg.REGION_CODE_APP)
gg.searchNumber("10000000", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll("-99", gg.TYPE_FLOAT)
gg.processResume()
gg.processResume()
gg.toast("✅ON✅")
    elseif MN8[2] == true then
  gg.setRanges(gg.REGION_CODE_APP)
gg.searchNumber("-99", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll("10000000", gg.TYPE_FLOAT)
gg.processResume()
gg.processResume()
gg.toast("✖OFF✖")
    elseif MN8[3] == true then
      return
    end
  end
end

function FOLDER3()
  while true do
    local MN8 = gg.multiChoice({
       "お金",
       "コイン",
       "送金",
       "ワールドセール",
       "お金固定",
      "戻る",

   }, nil, "お金")

    if MN8 == nil then
      gg.setVisible(false)
      while not gg.isVisible() do
        gg.sleep(100)
      end
      gg.setVisible(false)
      return
  elseif MN8[1] == true then
  gg.clearResults()
  valueFromClass("LevelDatas", "0x44", false, false, 16) 
  gg.getResults(9999)
  gg.editAll(5000000, 16) 
  gg.clearResults()
  stopClose()
    elseif MN8[2] == true then
local startAddr = getBaseAddr('libil2cpp.so')
  setvalue(startAddr + 0x211EEB4, "hC03196D2")
  setvalue(startAddr + 0x211EEB8, "hC0035FD6")
  gg.clearResults()
  stopClose()
    elseif MN8[3] == true then
local startAddr = getBaseAddr('libil2cpp.so')
setvalue(startAddr + 
0x61BBB98,10058041)  
gg.clearResults()
stopClose()
    elseif MN8[4] == true then
local startAddr = getBaseAddr('libil2cpp.so')
setvalue(startAddr + 
0x20C4864, 
"h200080D2")  
setvalue(startAddr + 
0x20C4868, 
"hC0035FD6")  
stopClose()
    elseif MN8[5] == true then
local startAddr = getBaseAddr('libil2cpp.so')
setvalue(startAddr + 
0x2182320, 
"h200080D2")  
setvalue(startAddr + 
0x2182324, 
"hC0035FD6")  
stopClose()
   elseif MN8[6] == true then
      return
    end
  end
end

function FOLDER4()
  while true do
    local MN8 = gg.multiChoice({
       "ルームパスワードハック",
       "ダメージ無効",
      "戻る",

   }, nil, "テスト")

    if MN8 == nil then
      gg.setVisible(false)
      while not gg.isVisible() do
        gg.sleep(100)
      end
      gg.setVisible(false)
      return
    elseif MN8[1] == true then
        valueFromClass("RoomDataItem", "0x94", false, false, 4)
    local results = gg.getResults(9999)

   
    local refinedResults = {}
    local seenValues = {} 
    for i, v in ipairs(results) do
        if v.value >= 1 and v.value <= 9999 and not seenValues[v.value] then
            table.insert(refinedResults, tostring(v.value)) 
            seenValues[v.value] = true
        end
    end
    if #refinedResults > 0 then
        local message = "パスワード:\n" .. table.concat(refinedResults, "\n") .. "\nの可能性が高いです。"
        gg.alert(message)
    else
        gg.alert("パスワードらしきものが見つかりませんでした")
    end
    gg.clearResults()
    stopClose() 
    elseif MN8[2] == true then
local startAddr = getBaseAddr('libil2cpp.so')
setvalue(startAddr + 
0x2093E0C, 
"h200080D2")  
setvalue(startAddr + 
0x2093E10, 
"hC0035FD6")  
stopClose()
    elseif MN8[3] == true then
      return
    end
  end
end


function valueFromClass(class, offset, tryHard, bit32, valueType)
Get_user_input = {}
Get_user_input[1] = class
Get_user_input[2] = offset
Get_user_input[3] = tryHard
Get_user_input[4] = bit32
Get_user_type = valueType
start()
end


function loopCheck()
if userMode == 1 then
UI()
elseif error == 3 then
stopClose()
end
end

function found_(message)
if error == 1 then
found2(message)
elseif error == 2 then
found3(message)
elseif error == 3 then
found4(message)
else
found(message)
end
end

function found(message)
if count == 0 then
gg.clearResults()
gg.clearList()
first_error = message
error = 1
second_start()
end
end
function found2(message)
if count == 0 then
gg.clearResults()
gg.clearList()
second_error = message
error = 2
third_start()
end
end

function found3(message)
if count == 0 then
gg.clearResults()
gg.clearList()
third_error = message
error = 3
fourth_start()
end
end

function found4(message)
if count == 0 then
gg.clearResults()
gg.clearList()

gg.setVisible(true)
loopCheck()
end
end
------------------------------------------
function user_input_taker()
::stort::
gg.clearResults()
if userMode == 1 then
if Get_user_input == nil then
default1 = "PlayerController"
default2 = "0x148"
default3 = false
default4 = false
else
default1 =Get_user_input[1]
default2 = Get_user_input[2]
default3 = Get_user_input[3]
default4 = Get_user_input[4]
end
Get_user_input = gg.prompt(
{""},
{default1,default2,default3,default4},
{"text","text","checkbox","checkbox"})
if Get_user_input ~= nil then
if (Get_user_input[1] == "") or (Get_user_input[2] == "") then
goto stort
end
else
goto stort
end
Get_user_type = gg.choice({""},nil,"")
if Get_user_type == 1 then
Get_user_type = 1
elseif Get_user_type == 2 then
Get_user_type = 4
elseif Get_user_type == 3 then
Get_user_type = 32
elseif Get_user_type == 4 then
Get_user_type = 16
elseif Get_user_type == 5 then
Get_user_type = 64
end
if Get_user_type ~= 1 then
if (Get_user_input[2] % 4) ~= 0 then
goto stort
end
end
end
error = 0 
end

function O_initial_search()
gg.setVisible(false)
user_input = ":"..Get_user_input[1] 
if Get_user_input[3] then
offst = 25
else
offst = 0
end
end

function O_dinitial_search()
if error > 1 then
gg.setRanges(gg.REGION_C_ALLOC)
else
gg.setRanges(gg.REGION_OTHER)
end
gg.searchNumber(user_input, 1)
count = gg.getResultsCount()
if count == 0 then
found_("O_dinitial_search")
return 0
end
Refiner = gg.getResults(1)
gg.refineNumber(Refiner[1].value, 1)
count = gg.getResultsCount()
if count == 0 then
found_("O_dinitial_search")
return 0
end
val = gg.getResults(count)
gg.addListItems(val)
end
function CA_pointer_search()
gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_OTHER)
gg.loadResults(gg.getListItems())
gg.searchPointer(offst)
count = gg.getResultsCount()
if count == 0 then
found_("CA_pointer_search")
return 0
end
vel = gg.getResults(count)
gg.clearList()
gg.addListItems(vel)
end

function CA_apply_offset()
if Get_user_input[4] then
tanker = 0xfffffffffffffff8
else
tanker = 0xfffffffffffffff0
end
local copy = false
local l = gg.getListItems()
if not copy then gg.removeListItems(l) end
for i, v in ipairs(l) do
	v.address = v.address + tanker
	if copy then v.name = v.name..' #2' end
end
gg.addListItems(l)
end

function CA2_apply_offset()
if Get_user_input[4] then
tanker = 0xfffffffffffffff8
else
tanker = 0xfffffffffffffff0
end
local copy = false
local l = gg.getListItems()
if not copy then gg.removeListItems(l) end
for i, v in ipairs(l) do
	v.address = v.address + tanker
	if copy then v.name = v.name..' #2' end
end
gg.addListItems(l)
end

function Q_apply_fix()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.loadResults(gg.getListItems())
gg.clearList()
count = gg.getResultsCount()
if count == 0 then
found_("Q_apply_fix")
return 0
end
yy = gg.getResults(1000)
gg.clearResults()
i = 1
c = 1
s = {}
while (i-1) < count do
yy[i].address = yy[i].address + 0xb400000000000000
gg.searchNumber(yy[i].address, gg.TYPE_QWORD)
cnt = gg.getResultsCount()
if 0 < cnt then
bytr = gg.getResults(cnt)
n = 1
while (n-1) < cnt do
s[c] = {}
s[c].address = bytr[n].address
s[c].flags = 32
n = n + 1
c = c + 1
end
end
gg.clearResults()
i = i + 1
end
gg.addListItems(s)
end

function A_base_value()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.loadResults(gg.getListItems())
gg.clearList()
gg.searchPointer(offst)
count = gg.getResultsCount()
if count == 0 then
found_("A_base_value")
return 0
end
tel = gg.getResults(count)
gg.addListItems(tel)
end

function A_base_accuracy()
gg.setRanges(gg.REGION_ANONYMOUS | gg.REGION_C_ALLOC)
gg.loadResults(gg.getListItems())
gg.clearList()
gg.searchPointer(offst)
count = gg.getResultsCount()
if count == 0 then
found_("A_base_accuracy")
return 0
end
kol = gg.getResults(count)
i = 1
h = {}
while (i-1) < count do
h[i] = {}
h[i].address = kol[i].value
h[i].flags = 32
i = i + 1
end
gg.addListItems(h)
end
function A_user_given_offset()
local old_save_list = gg.getListItems()
for i, v in ipairs(old_save_list) do
v.address = v.address + Get_user_input[2]
v.flags = Get_user_type
end
gg.clearResults()
gg.clearList()
gg.loadResults(old_save_list)
count = gg.getResultsCount()
if count == 0 then
found_("Q_apply_fix++")
return 0
end
gg.setVisible(true)
end
function common_start(initial_search, apply_fix, apply_offset, apply_pointer, base_value, error_threshold)
    initial_search()
    if error > error_threshold then
        return 0
    end
    apply_pointer()
    if error > error_threshold then
        return 0
    end
    if offst == 0 then
        apply_offset()
    end
    if apply_fix then
        apply_fix()
    end
    if base_value then
        base_value()
        if error > error_threshold then
            return 0
        end
    end
    if offst == 0 then
        A_base_accuracy()
    end
    if error > error_threshold then
        return 0
    end
    A_user_given_offset()
    if error > error_threshold then
        return 0
    end
    loopCheck()
    if error > error_threshold then
        return 0
    end
end
----------------------------------------
function start()
    user_input_taker()
    O_initial_search()
    common_start(O_dinitial_search, nil, CA_apply_offset, CA_pointer_search, A_base_value, 0)
end

function second_start()
    common_start(O_dinitial_search, Q_apply_fix, CA_apply_offset, CA_pointer_search, nil, 1)
end

function third_start()
    common_start(O_dinitial_search, nil, CA2_apply_offset, CA_pointer_search, A_base_value, 2)
end

function fourth_start()
    O_dinitial_search()
    CA_pointer_search()
    CA2_apply_offset()
    Q_apply_fix()
    if offst == 0 then
        A_base_accuracy()
    end
    A_user_given_offset()
    loopCheck()
end

function UI()
    gg.showUiButton()
    while true do
        if gg.isClickedUiButton() then
            start()
        end
    end
end

function stopClose()
    while true do
        HOME()
        gg.setVisible(false)
        while gg.isVisible() == false do
        end
    end
end

if userMode == 2 then
    stopClose()
else
    UI()
end
