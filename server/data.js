export const seedSets = [
  {
    id: "n5-set-1",
    level: "N5",
    order: 1,
    title: "N5 模擬試験（もぎしけん）",
    description: "Core vocabulary, beginner grammar, short reading, and everyday listening.",
    active: true,
    durationMinutes: 90,
  },
  {
    id: "n5-set-2",
    level: "N5",
    order: 2,
    title: "N5 模擬試験（もぎしけん）",
    description: "A second balanced paper for checking progress under timed conditions.",
    active: true,
    durationMinutes: 90,
  },
  {
    id: "n5-set-3",
    level: "N5",
    order: 3,
    title: "N5 模擬試験（もぎしけん）",
    description: "Fresh N5 questions covering language knowledge, reading, and listening.",
    active: true,
    durationMinutes: 90,
  },
];

const setOne = [
  ["vocabulary", "毎朝（まいあさ）、六時（ろくじ）に＿＿。", "Every morning, I ___ at six o’clock.", ["おきます", "ねます", "たべます", "のみます"], 0, "おきます means ‘wake up’."],
  ["vocabulary", "この本（ほん）は＿＿ですか。", "How much is this book?", ["いくら", "どこ", "だれ", "いつ"], 0, "いくら asks the price of something."],
  ["grammar-reading", "私（わたし）は日本語（にほんご）＿＿勉強（べんきょう）します。", "I study Japanese.", ["を", "に", "で", "が"], 0, "を marks 日本語（にほんご） as the object of 勉強（べんきょう）します."],
  ["grammar-reading", "昨日（きのう）、学校（がっこう）＿＿行（い）きませんでした。", "Yesterday, I did not go to school.", ["へ", "を", "が", "も"], 0, "へ marks the destination of movement."],
  ["listening", "田中（たなか）さんは何時（なんじ）に会社（かいしゃ）へ行（い）きますか。", "What time does Tanaka go to the office?", ["七時（しちじ）", "八時（はちじ）", "九時（くじ）", "十時（じゅうじ）"], 1, "The speaker says 八時（はちじ）, eight o’clock.", "田中（たなか）さんは毎朝（まいあさ）八時（はちじ）に会社（かいしゃ）へ行（い）きます。"],
  ["listening", "女（おんな）の人（ひと）は何（なに）を買（か）いますか。", "What will the woman buy?", ["水（みず）", "本（ほん）", "傘（かさ）", "花（はな）"], 2, "She decides to buy an umbrella, 傘（かさ）.", "雨（あめ）ですね。駅（えき）の店（みせ）で傘（かさ）を買（か）います。"],
];

const setTwo = [
  ["vocabulary", "駅（えき）まで＿＿で行（い）きます。", "I go to the station by bicycle.", ["じてんしゃ", "でんわ", "つくえ", "くるまや"], 0, "じてんしゃ means bicycle."],
  ["vocabulary", "今日（きょう）は天気（てんき）が＿＿です。", "The weather is good today.", ["いい", "おおきい", "ながい", "あまい"], 0, "いい means good and is used for weather."],
  ["grammar-reading", "机（つくえ）の上（うえ）＿＿本（ほん）があります。", "There is a book on the desk.", ["に", "を", "へ", "と"], 0, "に marks the location where something exists."],
  ["grammar-reading", "山田（やまだ）さんは魚（さかな）を食（た）べません。肉（にく）＿＿食（た）べません。", "Yamada does not eat fish. He does not eat meat either.", ["も", "は", "で", "へ"], 0, "も means ‘also’ or ‘either’ in a negative sentence."],
  ["listening", "二人（ふたり）はどこで会（あ）いますか。", "Where will the two people meet?", ["学校（がっこう）", "駅（えき）", "図書館（としょかん）", "公園（こうえん）"], 1, "They agree to meet at the station, 駅（えき）.", "三時（さんじ）に駅（えき）の前（まえ）で会（あ）いましょう。"],
  ["listening", "男（おとこ）の人（ひと）は何曜日（なんようび）に休（やす）みますか。", "Which day will the man take off?", ["月曜日（げつようび）", "火曜日（かようび）", "木曜日（もくようび）", "金曜日（きんようび）"], 2, "The man says Thursday, 木曜日（もくようび）.", "今週（こんしゅう）は木曜日（もくようび）に休（やす）みます。"],
];

const setThree = [
  ["vocabulary", "寒（さむ）いですから、窓（まど）を＿＿ください。", "It is cold, so please close the window.", ["しめて", "あけて", "つけて", "けして"], 0, "しめて is the て-form of しめる, ‘to close’."],
  ["vocabulary", "母（はは）は台所（だいどころ）で料理（りょうり）を＿＿。", "My mother makes food in the kitchen.", ["つくります", "あらいます", "かえります", "ならいます"], 0, "つくります means ‘makes’."],
  ["grammar-reading", "日曜日（にちようび）に映画（えいが）を見（み）＿＿行（い）きませんか。", "Would you like to go see a film on Sunday?", ["に", "を", "で", "が"], 0, "Verb stem + に行（い）く expresses going somewhere for a purpose."],
  ["grammar-reading", "この部屋（へや）はあの部屋（へや）＿＿広（ひろ）いです。", "This room is more spacious than that room.", ["より", "まで", "しか", "から"], 0, "より marks the item used for comparison."],
  ["listening", "先生（せんせい）は宿題（しゅくだい）をいつ出（だ）しますか。", "When will the teacher assign the homework?", ["今日（きょう）", "明日（あした）", "金曜日（きんようび）", "来週（らいしゅう）"], 1, "The teacher says tomorrow, 明日（あした）.", "宿題（しゅくだい）は明日（あした）出（だ）します。金曜日（きんようび）までにしてください。"],
  ["listening", "子供（こども）は何（なに）を飲（の）みますか。", "What will the child drink?", ["水（みず）", "お茶（ちゃ）", "牛乳（ぎゅうにゅう）", "ジュース"], 2, "The child chooses milk, 牛乳（ぎゅうにゅう）.", "ジュースはありません。牛乳（ぎゅうにゅう）をください。"],
];

export const seedQuestions = [setOne, setTwo, setThree].flatMap((items, setIndex) =>
  items.map(([section, prompt, promptEn, options, answer, explanation, audioText], questionIndex) => ({
    id: `n5-s${setIndex + 1}-q${questionIndex + 1}`,
    setId: `n5-set-${setIndex + 1}`,
    level: "N5",
    section,
    active: true,
    order: questionIndex + 1,
    prompt,
    promptEn,
    options,
    answer,
    explanation,
    audioText: audioText || null,
  })),
);
