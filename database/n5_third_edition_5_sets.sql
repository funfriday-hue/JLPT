-- JLPT Quiz: five original N5 mock-test sets
-- Curriculum reference: Minna no Nihongo Elementary I Third Edition, lessons 1–25.
-- Official reference: https://www.3anet.co.jp/np/en/books/1300/
-- The questions and listening scripts below are original; no textbook exercise or JLPT item is copied.
-- Each set: 21 vocabulary + 22 grammar/reading + 24 listening = 67 questions.
-- Safe to rerun against the schema in server/migrations/001_initial.sql.

SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET @OLD_SQL_MODE = @@SQL_MODE;
SET SQL_MODE = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
START TRANSACTION;

INSERT INTO exam_sets (id, level, order_no, title, description, active, duration_minutes)
VALUES
('n5-set-1', 'N5', 1, 'N5 模擬試験（もぎしけん）セット 1', 'Minna no Nihongo Elementary I Third Edition lessons 1–25 aligned original N5 practice paper.', TRUE, 90),
('n5-set-2', 'N5', 2, 'N5 模擬試験（もぎしけん）セット 2', 'Minna no Nihongo Elementary I Third Edition lessons 1–25 aligned original N5 practice paper.', TRUE, 90),
('n5-set-3', 'N5', 3, 'N5 模擬試験（もぎしけん）セット 3', 'Minna no Nihongo Elementary I Third Edition lessons 1–25 aligned original N5 practice paper.', TRUE, 90),
('n5-set-4', 'N5', 4, 'N5 模擬試験（もぎしけん）セット 4', 'Minna no Nihongo Elementary I Third Edition lessons 1–25 aligned original N5 practice paper.', TRUE, 90),
('n5-set-5', 'N5', 5, 'N5 模擬試験（もぎしけん）セット 5', 'Minna no Nihongo Elementary I Third Edition lessons 1–25 aligned original N5 practice paper.', TRUE, 90)
ON DUPLICATE KEY UPDATE
  level = VALUES(level),
  order_no = VALUES(order_no),
  title = VALUES(title),
  description = VALUES(description),
  active = VALUES(active),
  duration_minutes = VALUES(duration_minutes),
  updated_at = CURRENT_TIMESTAMP(3);

INSERT INTO questions
  (id, set_id, level, section, active, order_no, prompt, prompt_en, options, answer_index, explanation, audio_text)
VALUES
('n5-s1-q1', 'n5-set-1', 'N5', 'vocabulary', TRUE, 1, '毎朝（まいあさ）、六時（ろくじ）に＿＿。', 'Every morning, I ___ at six o’clock.', '["おきます","ねます","たべます","のみます"]', 0, '第（だい）4課（か）・文脈語彙（ぶんみゃくごい）: おきます means ‘wake up’.', NULL),
('n5-s1-q2', 'n5-set-1', 'N5', 'vocabulary', TRUE, 2, 'この本（ほん）は＿＿ですか。', 'How much is this book?', '["いくら","どこ","だれ","いつ"]', 0, '第（だい）3課（か）・文脈語彙（ぶんみゃくごい）: いくら asks the price of something.', NULL),
('n5-s1-q3', 'n5-set-1', 'N5', 'grammar-reading', TRUE, 3, '私（わたし）は日本語（にほんご）＿＿勉強（べんきょう）します。', 'I study Japanese.', '["を","に","で","が"]', 0, '第（だい）6課（か）・文法形式（ぶんぽうけいしき）: を marks 日本語（にほんご） as the object of 勉強（べんきょう）します.', NULL),
('n5-s1-q4', 'n5-set-1', 'N5', 'grammar-reading', TRUE, 4, '昨日（きのう）、学校（がっこう）＿＿行（い）きませんでした。', 'Yesterday, I did not go to school.', '["へ","を","が","も"]', 0, '第（だい）5課（か）・文法形式（ぶんぽうけいしき）: へ marks the destination of movement.', NULL),
('n5-s1-q5', 'n5-set-1', 'N5', 'listening', TRUE, 5, '田中（たなか）さんは何時（なんじ）に会社（かいしゃ）へ行（い）きますか。', 'What time does Tanaka go to the office?', '["七時（しちじ）","八時（はちじ）","九時（くじ）","十時（じゅうじ）"]', 1, '第（だい）4課（か）・課題理解（かだいりかい）: The speaker says 八時（はちじ）, eight o’clock.', '田中（たなか）さんは毎朝（まいあさ）八時（はちじ）に会社（かいしゃ）へ行（い）きます。'),
('n5-s1-q6', 'n5-set-1', 'N5', 'listening', TRUE, 6, '女（おんな）の人（ひと）は何（なに）を買（か）いますか。', 'What will the woman buy?', '["水（みず）","本（ほん）","傘（かさ）","花（はな）"]', 2, '第（だい）6課（か）・要点理解（ようてんりかい）: She decides to buy an umbrella, 傘（かさ）.', '雨（あめ）ですね。駅（えき）の店（みせ）で傘（かさ）を買（か）います。'),
('n5-s1-q7', 'n5-set-1', 'N5', 'vocabulary', TRUE, 7, '毎朝（まいあさ）、駅へ行（い）きます。
「駅」の読（よ）み方（かた）を選（えら）んでください。', 'Choose the reading of 駅.', '["いえ","みち","えき","みせ"]', 2, '第（だい）3課（か）・漢字読（かんじよ）み: 「駅」は「えき」と読（よ）みます。', NULL),
('n5-s1-q8', 'n5-set-1', 'N5', 'vocabulary', TRUE, 8, '山田（やまだ）さんは先生です。
「先生」の読（よ）み方（かた）を選（えら）んでください。', 'Choose the reading of 先生.', '["せんしょう","せんせい","せんせ","せいせん"]', 1, '第（だい）1課（か）・漢字読（かんじよ）み: 「先生」は「せんせい」と読（よ）みます。', NULL),
('n5-s1-q9', 'n5-set-1', 'N5', 'vocabulary', TRUE, 9, '学校は九時（くじ）からです。
「学校」の読（よ）み方（かた）を選（えら）んでください。', 'Choose the reading of 学校.', '["がっこう","がこう","がくこう","がっこ"]', 0, '第（だい）3課（か）・漢字読（かんじよ）み: 「学校」は「がっこう」と読（よ）みます。', NULL),
('n5-s1-q10', 'n5-set-1', 'N5', 'vocabulary', TRUE, 10, '今（いま）、時間がありますか。
「時間」の読（よ）み方（かた）を選（えら）んでください。', 'Choose the reading of 時間.', '["しかん","じけん","ときま","じかん"]', 3, '第（だい）4課（か）・漢字読（かんじよ）み: 「時間」は「じかん」と読（よ）みます。', NULL),
('n5-s1-q11', 'n5-set-1', 'N5', 'vocabulary', TRUE, 11, '電車で東京（とうきょう）へ行（い）きます。
「電車」の読（よ）み方（かた）を選（えら）んでください。', 'Choose the reading of 電車.', '["でんじゃ","でんさ","でんしゃ","てんしゃ"]', 2, '第（だい）5課（か）・漢字読（かんじよ）み: 「電車」は「でんしゃ」と読（よ）みます。', NULL),
('n5-s1-q12', 'n5-set-1', 'N5', 'vocabulary', TRUE, 12, '友達と京都（きょうと）へ行（い）きます。
「友達」の読（よ）み方（かた）を選（えら）んでください。', 'Choose the reading of 友達.', '["ともみち","ともだち","ともたち","ゆうだち"]', 1, '第（だい）5課（か）・漢字読（かんじよ）み: 「友達」は「ともだち」と読（よ）みます。', NULL),
('n5-s1-q13', 'n5-set-1', 'N5', 'vocabulary', TRUE, 13, '日曜日に仕事（しごと）をしません。
「日曜日」の読（よ）み方（かた）を選（えら）んでください。', 'Choose the reading of 日曜日.', '["にちようび","ひようび","げつようび","にちよび"]', 0, '第（だい）4課（か）・漢字読（かんじよ）み: 「日曜日」は「にちようび」と読（よ）みます。', NULL),
('n5-s1-q14', 'n5-set-1', 'N5', 'vocabulary', TRUE, 14, 'これは『みず』です。
『みず』の漢字（かんじ）を選（えら）んでください。', 'Choose the kanji for みず.', '["木","火","月","水"]', 3, '第（だい）2課（か）・表記（ひょうき）: 『みず』は「水」と書（か）きます。', NULL),
('n5-s1-q15', 'n5-set-1', 'N5', 'vocabulary', TRUE, 15, '『くるま』で行（い）きます。
『くるま』の漢字（かんじ）を選（えら）んでください。', 'Choose the kanji for くるま.', '["電","道","車","東"]', 2, '第（だい）5課（か）・表記（ひょうき）: 『くるま』は「車」と書（か）きます。', NULL),
('n5-s1-q16', 'n5-set-1', 'N5', 'vocabulary', TRUE, 16, 'あの『やま』は高（たか）いです。
『やま』の漢字（かんじ）を選（えら）んでください。', 'Choose the kanji for やま.', '["土","山","川","田"]', 1, '第（だい）8課（か）・表記（ひょうき）: 『やま』は「山」と書（か）きます。', NULL),
('n5-s1-q17', 'n5-set-1', 'N5', 'vocabulary', TRUE, 17, '『かわ』の水（みず）はきれいです。
『かわ』の漢字（かんじ）を選（えら）んでください。', 'Choose the kanji for かわ.', '["川","山","口","中"]', 0, '第（だい）8課（か）・表記（ひょうき）: 『かわ』は「川」と書（か）きます。', NULL),
('n5-s1-q18', 'n5-set-1', 'N5', 'vocabulary', TRUE, 18, 'これは『ひゃく』円（えん）です。
『ひゃく』の漢字（かんじ）を選（えら）んでください。', 'Choose the kanji for ひゃく.', '["白","千","円","百"]', 3, '第（だい）11課（か）・表記（ひょうき）: 『ひゃく』は「百」と書（か）きます。', NULL),
('n5-s1-q19', 'n5-set-1', 'N5', 'vocabulary', TRUE, 19, '手（て）が汚（よご）れましたから、＿＿。', 'Choose the word that best completes the sentence.', '["借（か）ります","教（おし）えます","洗（あら）います","開（あ）けます"]', 2, '第（だい）6課（か）・文脈語彙（ぶんみゃくごい）: 洗（あら）います means wash.', NULL),
('n5-s1-q20', 'n5-set-1', 'N5', 'vocabulary', TRUE, 20, '本（ほん）は机（つくえ）の＿＿にあります。', 'Choose the word that best completes the sentence.', '["国（くに）","上（うえ）","人（ひと）","時（とき）"]', 1, '第（だい）10課（か）・文脈語彙（ぶんみゃくごい）: 上（うえ） expresses position.', NULL),
('n5-s1-q21', 'n5-set-1', 'N5', 'vocabulary', TRUE, 21, '切手（きって）を＿＿買（か）いました。', 'Choose the word that best completes the sentence.', '["二枚（にまい）","二人（ふたり）","二台（にだい）","二本（にほん）"]', 0, '第（だい）11課（か）・文脈語彙（ぶんみゃくごい）: 枚（まい） counts thin, flat objects.', NULL),
('n5-s1-q22', 'n5-set-1', 'N5', 'vocabulary', TRUE, 22, '喉（のど）が渇（かわ）きました。水（みず）が＿＿です。', 'Choose the word that best completes the sentence.', '["すき","じょうず","ひま","ほしい"]', 3, '第（だい）13課（か）・文脈語彙（ぶんみゃくごい）: ほしい expresses wanting a thing.', NULL),
('n5-s1-q23', 'n5-set-1', 'N5', 'vocabulary', TRUE, 23, 'この町（まち）は静（しず）かです。
同（おな）じ意味（いみ）の文（ぶん）を選（えら）んでください。', 'Choose the sentence with the same meaning.', '["この町（まち）は古（ふる）くありません。","この町（まち）は便利（べんり）です。","この町（まち）はにぎやかではありません。","この町（まち）は大（おお）きいです。"]', 2, '第（だい）8課（か）・言（い）い換（か）え: 静（しず）か means not noisy.', NULL),
('n5-s1-q24', 'n5-set-1', 'N5', 'vocabulary', TRUE, 24, '私（わたし）は野菜（やさい）が嫌（きら）いです。
同（おな）じ意味（いみ）の文（ぶん）を選（えら）んでください。', 'Choose the sentence with the same meaning.', '["私（わたし）は野菜（やさい）が分（わ）かります。","私（わたし）は野菜（やさい）が好（す）きではありません。","私（わたし）は野菜（やさい）がほしいです。","私（わたし）は野菜（やさい）を作（つく）ります。"]', 1, '第（だい）9課（か）・言（い）い換（か）え: 嫌（きら）い means not liking something.', NULL),
('n5-s1-q25', 'n5-set-1', 'N5', 'vocabulary', TRUE, 25, '今日（きょう）は昨日（きのう）より暑（あつ）いです。
同（おな）じ意味（いみ）の文（ぶん）を選（えら）んでください。', 'Choose the sentence with the same meaning.', '["昨日（きのう）は今日（きょう）ほど暑（あつ）くありません。","昨日（きのう）も今日（きょう）も同（おな）じです。","今日（きょう）は昨日（きのう）ほど暑（あつ）くありません。","昨日（きのう）は今日（きょう）より寒（さむ）くありません。"]', 0, '第（だい）12課（か）・言（い）い換（か）え: A より B and B ほど...ない express the same comparison.', NULL),
('n5-s1-q26', 'n5-set-1', 'N5', 'grammar-reading', TRUE, 26, '＿＿は辞書（じしょ）です。私（わたし）の近（ちか）くにあります。', 'This near me is a dictionary.', '["この","ここ","どれ","これ"]', 3, '第（だい）2課（か）・文法形式（ぶんぽうけいしき）: これ refers to a thing near the speaker and stands alone.', NULL),
('n5-s1-q27', 'n5-set-1', 'N5', 'grammar-reading', TRUE, 27, '田中（たなか）は八時（はちじ）＿＿起（お）きます。', '田中（たなか） gets up at 八時（はちじ）.', '["を","へ","に","で"]', 2, '第（だい）4課（か）・文法形式（ぶんぽうけいしき）: に marks a specific time.', NULL),
('n5-s1-q28', 'n5-set-1', 'N5', 'grammar-reading', TRUE, 28, '日本語（にほんご）＿＿手紙（てがみ）を書（か）きます。', 'I write a letter in Japanese.', '["へ","で","を","に"]', 1, '第（だい）7課（か）・文法形式（ぶんぽうけいしき）: で marks the language or means used.', NULL),
('n5-s1-q29', 'n5-set-1', 'N5', 'grammar-reading', TRUE, 29, '図書館（としょかん）＿＿山田（やまだ）がいます。', '山田（やまだ） is at the 図書館（としょかん）.', '["に","を","で","へ"]', 0, '第（だい）10課（か）・文法形式（ぶんぽうけいしき）: に marks the place where a person exists.', NULL),
('n5-s1-q30', 'n5-set-1', 'N5', 'grammar-reading', TRUE, 30, 'すみません。名前（なまえ）を書（か）いて＿＿。', 'Please do the requested action.', '["います","あります","なります","ください"]', 3, '第（だい）14課（か）・文法形式（ぶんぽうけいしき）: The て-form plus ください makes a polite request.', NULL),
('n5-s1-q31', 'n5-set-1', 'N5', 'grammar-reading', TRUE, 31, '明日（あした）までに宿題（しゅくだい）をしなければ＿＿。', 'The action must be completed by tomorrow.', '["いけます","ください","なりません","ありません"]', 2, '第（だい）17課（か）・文法形式（ぶんぽうけいしき）: ない-form without い + ければなりません expresses obligation.', NULL),
('n5-s1-q32', 'n5-set-1', 'N5', 'grammar-reading', TRUE, 32, '時間（じかん）が＿＿、友達（ともだち）に会（あ）います。', 'Choose the たら conditional form.', '["あるまで","あったら","あっても","ありますから"]', 1, '第（だい）25課（か）・文法形式（ぶんぽうけいしき）: The たら form expresses a condition for the following action.', NULL),
('n5-s1-q33', 'n5-set-1', 'N5', 'grammar-reading', TRUE, 33, '朝（あさ）の順番（じゅんばん）として正（ただ）しい文（ぶん）はどれですか。', 'Choose the correctly formed sentence.', '["朝（あさ）起（お）きて、顔（かお）を洗（あら）って、ご飯（はん）を食（た）べます。","朝（あさ）起（お）きますて、顔（かお）を洗（あら）いますて、ご飯（はん）を食（た）べます。","朝（あさ）起（お）きて、顔（かお）を洗（あら）うて、ご飯（はん）を食（た）べます。","朝（あさ）起（お）きた、顔（かお）を洗（あら）って、ご飯（はん）を食（た）べます。"]', 0, '第（だい）16課（か）・文（ぶん）の組（く）み立（た）て: て-forms connect actions in sequence.', NULL),
('n5-s1-q34', 'n5-set-1', 'N5', 'grammar-reading', TRUE, 34, '正（ただ）しい文（ぶん）を選（えら）んでください。', 'Choose the correctly formed sentence.', '["寝（ね）ます前（まえ）に、歯（は）を磨（みが）きます。","寝（ね）た前（まえ）に、歯（は）を磨（みが）きます。","寝（ね）て前（まえ）に、歯（は）を磨（みが）きます。","寝（ね）る前（まえ）に、歯（は）を磨（みが）きます。"]', 3, '第（だい）18課（か）・文（ぶん）の組（く）み立（た）て: Dictionary form + 前（まえ）に means before doing something.', NULL),
('n5-s1-q35', 'n5-set-1', 'N5', 'grammar-reading', TRUE, 35, '経験（けいけん）について正（ただ）しい文（ぶん）はどれですか。', 'Choose the correctly formed sentence.', '["富士山（ふじさん）に登（のぼ）ってことがあります。","富士山（ふじさん）に登（のぼ）りことがあります。","富士山（ふじさん）に登（のぼ）ったことがあります。","富士山（ふじさん）に登（のぼ）ることがありました。"]', 2, '第（だい）19課（か）・文（ぶん）の組（く）み立（た）て: た-form + ことがあります expresses experience.', NULL),
('n5-s1-q36', 'n5-set-1', 'N5', 'grammar-reading', TRUE, 36, '考（かんが）えを言（い）う正（ただ）しい文（ぶん）はどれですか。', 'Choose the correctly formed sentence.', '["明日（あした）は雨（あめ）が降（ふ）るを思（おも）います。","明日（あした）は雨（あめ）が降（ふ）ると思（おも）います。","明日（あした）は雨（あめ）が降（ふ）りますと思（おも）います。","明日（あした）は雨（あめ）が降（ふ）ってと思（おも）います。"]', 1, '第（だい）21課（か）・文（ぶん）の組（く）み立（た）て: Plain form + と思（おも）います reports an opinion.', NULL),
('n5-s1-q37', 'n5-set-1', 'N5', 'grammar-reading', TRUE, 37, '友達（ともだち）からメッセージが来（き）ました。『明日（あした）、駅（えき）へ＿＿？』', 'Choose the grammar that best completes the text.', '["来（く）る","来（き）ます","来（き）て","来（き）た"]', 0, '第（だい）20課（か）・文章文法（ぶんしょうぶんぽう）: Plain-style questions use the dictionary form in casual conversation.', NULL),
('n5-s1-q38', 'n5-set-1', 'N5', 'grammar-reading', TRUE, 38, '家（いえ）を出（で）る＿＿、電気（でんき）を消（け）してください。', 'Choose the grammar that best completes the text.', '["から","まで","より","とき"]', 3, '第（だい）23課（か）・文章文法（ぶんしょうぶんぽう）: Dictionary form + とき means when/before leaving.', NULL),
('n5-s1-q39', 'n5-set-1', 'N5', 'grammar-reading', TRUE, 39, '道（みち）が分（わ）からなかったので、友達（ともだち）に地図（ちず）を書（か）いて＿＿。', 'Choose the grammar that best completes the text.', '["くれましたか","しました","もらいました","あげました"]', 2, '第（だい）24課（か）・文章文法（ぶんしょうぶんぽう）: て-form + もらいました presents a helpful action received from someone.', NULL),
('n5-s1-q40', 'n5-set-1', 'N5', 'grammar-reading', TRUE, 40, '短（みじか）い文章（ぶんしょう）を読（よ）んでください。
田中（たなか）さんは毎朝（まいあさ）六時半（ろくじはん）に起（お）きます。七時（しちじ）に朝（あさ）ご飯（はん）を食（た）べて、八時（はちじ）に会社（かいしゃ）へ行（い）きます。
田中（たなか）さんは何時（なんじ）に朝（あさ）ご飯（はん）を食（た）べますか。', 'Tanaka gets up at 6:30, eats breakfast at 7:00, and goes to work at 8:00. What time does he eat breakfast?', '["八時（はちじ）","七時（しちじ）","六時（ろくじ）","六時半（ろくじはん）"]', 1, '第（だい）4課（か）・読解（どっかい）: The passage says breakfast is at seven.', NULL),
('n5-s1-q41', 'n5-set-1', 'N5', 'grammar-reading', TRUE, 41, 'メールを読（よ）んでください。
山田（やまだ）さんへ
日曜日（にちようび）に新（あたら）しい映画（えいが）を見（み）に行（い）きませんか。二時（にじ）に駅（えき）の前（まえ）で会（あ）いましょう。
木村（きむら）
二人（ふたり）はどうして会（あ）いますか。', 'Kimura invites Yamada to see a new movie on Sunday and meet at the station at 2:00. Why will they meet?', '["映画（えいが）を見（み）るため","買（か）い物（もの）をするため","勉強（べんきょう）するため","仕事（しごと）をするため"]', 0, '第（だい）13課（か）・読解（どっかい）: They will meet to see a new movie.', NULL),
('n5-s1-q42', 'n5-set-1', 'N5', 'grammar-reading', TRUE, 42, '図書館（としょかん）のお知（し）らせ
月曜日（げつようび）から金曜日（きんようび）：午前九時（ごぜんくじ）から午後七時（ごごしちじ）
土曜日（どようび）：午前十時（ごぜんじゅうじ）から午後五時（ごごごじ）
日曜日（にちようび）：休（やす）み
本（ほん）を借（か）りられるのはいつですか。', 'Library hours are weekdays 9–7, Saturday 10–5, and closed Sunday. When can a book be borrowed?', '["日曜日（にちようび）の午前十時（ごぜんじゅうじ）","月曜日（げつようび）の午後八時（ごごはちじ）","土曜日（どようび）の午後六時（ごごろくじ）","土曜日（どようび）の午後三時（ごごさんじ）"]', 3, '第（だい）11課（か）・読解（どっかい）: Saturday at 3:00 p.m. is within opening hours.', NULL),
('n5-s1-q43', 'n5-set-1', 'N5', 'grammar-reading', TRUE, 43, 'りんごは一（ひと）つ百円（ひゃくえん）です。みかんは一（ひと）つ八十円（はちじゅうえん）です。りんごはみかんより大（おお）きいです。
正（ただ）しい文（ぶん）はどれですか。', 'Apples cost 100 yen and mikan cost 80 yen. Apples are larger. Which sentence is correct?', '["みかんはりんごより大（おお）きいです。","二（ふた）つは同（おな）じ値段（ねだん）です。","みかんはりんごより安（やす）いです。","りんごはみかんより安（やす）いです。"]', 2, '第（だい）12課（か）・読解（どっかい）: Mikan cost less than apples.', NULL),
('n5-s1-q44', 'n5-set-1', 'N5', 'grammar-reading', TRUE, 44, '私（わたし）が昨日（きのう）買（か）った本（ほん）は机（つくえ）の上（うえ）にあります。友達（ともだち）にもらった本（ほん）は棚（たな）の中（なか）です。
机（つくえ）の上（うえ）にあるのはどの本（ほん）ですか。', 'The book I bought yesterday is on the desk; the book from my friend is on the shelf. Which is on the desk?', '["図書館（としょかん）で借（か）りた本（ほん）","私（わたし）が昨日（きのう）買（か）った本（ほん）","友達（ともだち）にもらった本（ほん）","先生（せんせい）が読（よ）んだ本（ほん）"]', 1, '第（だい）22課（か）・読解（どっかい）: The relative clause identifies the book bought yesterday.', NULL),
('n5-s1-q45', 'n5-set-1', 'N5', 'grammar-reading', TRUE, 45, '公園（こうえん）のきまり
・自転車（じてんしゃ）で入（はい）ってはいけません。
・犬（いぬ）と散歩（さんぽ）してもいいです。
・ごみは持（も）って帰（かえ）ってください。
してもいいことはどれですか。', 'Park rules prohibit bicycles, allow dog walking, and require taking trash home. What is allowed?', '["犬（いぬ）と散歩（さんぽ）する","自転車（じてんしゃ）で入（はい）る","ごみを置（お）く","夜（よる）に火（ひ）を使（つか）う"]', 0, '第（だい）15課（か）・読解（どっかい）: The rules explicitly allow walking a dog.', NULL),
('n5-s1-q46', 'n5-set-1', 'N5', 'listening', TRUE, 46, '男（おとこ）の人（ひと）はどこへ行（い）きますか。', 'Listen and choose what the person will do.', '["銀行（ぎんこう）","病院（びょういん）","図書館（としょかん）","郵便局（ゆうびんきょく）"]', 3, '第（だい）3課（か）・課題理解（かだいりかい）: He goes to the post office first.', '手紙（てがみ）を出（だ）しますから、郵便局（ゆうびんきょく）へ行（い）きます。それから銀行（ぎんこう）へ行（い）きます。'),
('n5-s1-q47', 'n5-set-1', 'N5', 'listening', TRUE, 47, '女（おんな）の人（ひと）は何（なに）で駅（えき）へ行（い）きますか。', 'Listen and choose what the person will do.', '["自転車（じてんしゃ）","歩（ある）いて","バス","電車（でんしゃ）"]', 2, '第（だい）5課（か）・課題理解（かだいりかい）: She will take the bus because it is raining.', '雨（あめ）ですから、自転車（じてんしゃ）は使（つか）いません。駅（えき）までバスで行（い）きます。'),
('n5-s1-q48', 'n5-set-1', 'N5', 'listening', TRUE, 48, '学生（がくせい）は先生（せんせい）に何（なに）を見（み）せますか。', 'Listen and choose what the person will do.', '["手紙（てがみ）","宿題（しゅくだい）","辞書（じしょ）","写真（しゃしん）"]', 1, '第（だい）7課（か）・課題理解（かだいりかい）: The student will show the homework.', '宿題（しゅくだい）が終（お）わりました。先生（せんせい）に見（み）せてから、図書館（としょかん）へ行（い）きます。'),
('n5-s1-q49', 'n5-set-1', 'N5', 'listening', TRUE, 49, '女（おんな）の人（ひと）は切手（きって）を何枚（なんまい）買（か）いますか。', 'Listen and choose what the person will do.', '["三枚（さんまい）","二枚（にまい）","四枚（よんまい）","五枚（ごまい）"]', 0, '第（だい）11課（か）・課題理解（かだいりかい）: She needs three stamps for three letters.', '手紙（てがみ）が三通（さんつう）ありますから、切手（きって）を三枚（さんまい）ください。'),
('n5-s1-q50', 'n5-set-1', 'N5', 'listening', TRUE, 50, '二人（ふたり）は何（なに）をしに行（い）きますか。', 'Listen and choose what the person will do.', '["本（ほん）を買（か）います","写真（しゃしん）を撮（と）ります","ご飯（はん）を食（た）べます","映画（えいが）を見（み）ます"]', 3, '第（だい）13課（か）・課題理解（かだいりかい）: They will go to see a new movie.', '新（あたら）しい映画（えいが）が始（はじ）まりました。一緒（いっしょ）に見（み）に行（い）きませんか。')
ON DUPLICATE KEY UPDATE
  set_id = VALUES(set_id),
  level = VALUES(level),
  section = VALUES(section),
  active = VALUES(active),
  order_no = VALUES(order_no),
  prompt = VALUES(prompt),
  prompt_en = VALUES(prompt_en),
  options = VALUES(options),
  answer_index = VALUES(answer_index),
  explanation = VALUES(explanation),
  audio_text = VALUES(audio_text),
  updated_at = CURRENT_TIMESTAMP(3);

INSERT INTO questions
  (id, set_id, level, section, active, order_no, prompt, prompt_en, options, answer_index, explanation, audio_text)
VALUES
('n5-s1-q51', 'n5-set-1', 'N5', 'listening', TRUE, 51, '会議（かいぎ）は何時（なんじ）からですか。', 'Listen and choose the key detail.', '["十一時（じゅういちじ）","九時半（くじはん）","十時半（じゅうじはん）","十時（じゅうじ）"]', 2, '第（だい）4課（か）・要点理解（ようてんりかい）: The corrected time is 10:30.', '会議（かいぎ）は十時（じゅうじ）ではありません。十時半（じゅうじはん）からです。'),
('n5-s1-q52', 'n5-set-1', 'N5', 'listening', TRUE, 52, '女（おんな）の人（ひと）は昼（ひる）ご飯（はん）に何（なに）を食（た）べますか。', 'Listen and choose the key detail.', '["すし","そば","カレー","パン"]', 1, '第（だい）6課（か）・要点理解（ようてんりかい）: She chooses soba for lunch.', '朝（あさ）はパンを食（た）べました。昼（ひる）はそばにします。'),
('n5-s1-q53', 'n5-set-1', 'N5', 'listening', TRUE, 53, '男（おとこ）の人（ひと）はどのかばんを買（か）いますか。', 'Listen and choose the key detail.', '["軽（かる）いかばん","大（おお）きいかばん","高（たか）いかばん","赤（あか）いかばん"]', 0, '第（だい）8課（か）・要点理解（ようてんりかい）: He chooses the light bag.', '大（おお）きいかばんは重（おも）いですね。この軽（かる）いかばんをください。'),
('n5-s1-q54', 'n5-set-1', 'N5', 'listening', TRUE, 54, '女（おんな）の人（ひと）はどうして漢字（かんじ）が分（わ）かりますか。', 'Listen and choose the key detail.', '["日本人（にほんじん）ですから","先生（せんせい）ですから","辞書（じしょ）がありませんから","毎日（まいにち）勉強（べんきょう）しますから"]', 3, '第（だい）9課（か）・要点理解（ようてんりかい）: Daily study is the stated reason.', '毎日（まいにち）漢字（かんじ）を勉強（べんきょう）していますから、少（すこ）し分（わ）かります。'),
('n5-s1-q55', 'n5-set-1', 'N5', 'listening', TRUE, 55, '旅行（りょこう）はどうでしたか。', 'Listen and choose the key detail.', '["短（みじか）くありません","静（しず）かではありません","楽（たの）しかったです","寒（さむ）くなかったです"]', 2, '第（だい）12課（か）・要点理解（ようてんりかい）: Despite rain, the trip was fun.', '雨（あめ）が降（ふ）りましたが、友達（ともだち）と一緒（いっしょ）で楽（たの）しかったです。'),
('n5-s1-q56', 'n5-set-1', 'N5', 'listening', TRUE, 56, '初（はじ）めて会（あ）う人（ひと）に何（なん）と言（い）いますか。', 'What do you say when meeting someone for the first time?', '["お大事（だいじ）に。","初（はじ）めまして。","いただきます。","お帰（かえ）りなさい。"]', 1, '第（だい）1課（か）・発話表現（はつわひょうげん）: 初（はじ）めまして is used at a first meeting.', 'あなたはインドから来（き）ました。初（はじ）めて田中（たなか）に会（あ）います。何（なん）と言（い）いますか。'),
('n5-s1-q57', 'n5-set-1', 'N5', 'listening', TRUE, 57, '店（みせ）で値段（ねだん）を聞（き）きます。何（なん）と言（い）いますか。', 'What do you say to ask the price in a shop?', '["この時計（とけい）はいくらですか。","この時計（とけい）はどこですか。","この時計（とけい）はだれですか。","この時計（とけい）はいつですか。"]', 0, '第（だい）2課（か）・発話表現（はつわひょうげん）: いくら asks a price.', '店（みせ）でこの時計（とけい）の値段（ねだん）を知（し）りたいです。何（なん）と言（い）いますか。'),
('n5-s1-q58', 'n5-set-1', 'N5', 'listening', TRUE, 58, '丁寧（ていねい）にお願（ねが）いします。何（なん）と言（い）いますか。', 'Which expression makes the polite request?', '["窓（まど）を閉（し）めるません。","窓（まど）を閉（し）めることがあります。","窓（まど）を閉（し）めるたいです。","窓（まど）を閉（し）めてください。"]', 3, '第（だい）14課（か）・発話表現（はつわひょうげん）: The て-form plus ください makes a polite request.', '山田（やまだ）に窓（まど）を閉（し）めることをお願（ねが）いします。何（なん）と言（い）いますか。'),
('n5-s1-q59', 'n5-set-1', 'N5', 'listening', TRUE, 59, '許可（きょか）を聞（き）きます。何（なん）と言（い）いますか。', 'What do you say to ask permission?', '["ここに座（すわ）らないでください。","ここに座（すわ）らなければなりません。","ここに座（すわ）ってもいいですか。","ここに座（すわ）ってはいけません。"]', 2, '第（だい）15課（か）・発話表現（はつわひょうげん）: て-form + もいいですか asks permission.', 'ここに座（すわ）りたいです。先生（せんせい）に何（なん）と言（い）いますか。'),
('n5-s1-q60', 'n5-set-1', 'N5', 'listening', TRUE, 60, '手伝（てつだ）いを申（もう）し出（で）ます。何（なん）と言（い）いますか。', 'What do you say to offer help?', '["この荷物（にもつ）を持（も）たないでください。","この荷物（にもつ）を持（も）ちましょうか。","この荷物（にもつ）を持（も）ってはいけません。","この荷物（にもつ）を持（も）ちたいですか。"]', 1, '第（だい）16課（か）・発話表現（はつわひょうげん）: Verb stem + ましょうか can offer assistance.', '田中（たなか）がこの荷物（にもつ）を運（はこ）んでいます。手伝（てつだ）いたいです。何（なん）と言（い）いますか。'),
('n5-s1-q61', 'n5-set-1', 'N5', 'listening', TRUE, 61, '友達（ともだち）の助（たす）けにお礼（れい）を言（い）います。何（なん）と言（い）いますか。', 'What do you say to thank a friend for helping?', '["地図（ちず）を書（か）いてくれて、ありがとう。","地図（ちず）を書（か）いてはいけません。","地図（ちず）を書（か）いてくださいか。","地図（ちず）を書（か）いてありません。"]', 0, '第（だい）24課（か）・発話表現（はつわひょうげん）: てくれてありがとう thanks someone for a helpful action.', '山田（やまだ）が地図（ちず）を書（か）いてくれました。何（なん）と言（い）いますか。'),
('n5-s1-q62', 'n5-set-1', 'N5', 'listening', TRUE, 62, 'いちばん自然（しぜん）な返事（へんじ）を選（えら）んでください。', 'Choose the most natural response.', '["はい、います。","いいえ、ありませんでしたか。","いいえ、します。","はい、あります。"]', 3, '第（だい）19課（か）・即時応答（そくじおうとう）: はい、あります answers an experience question.', '富士山（ふじさん）に登（のぼ）ったことがありますか。'),
('n5-s1-q63', 'n5-set-1', 'N5', 'listening', TRUE, 63, 'いちばん自然（しぜん）な返事（へんじ）を選（えら）んでください。', 'Choose the most natural casual response.', '["いいえ、行（い）きました。","うん、ありません。","うん、いいよ。","はい、いいですか。"]', 2, '第（だい）20課（か）・即時応答（そくじおうとう）: うん、いいよ is a natural casual acceptance.', '明日（あした）、映画（えいが）を見（み）に行（い）く？'),
('n5-s1-q64', 'n5-set-1', 'N5', 'listening', TRUE, 64, 'いちばん自然（しぜん）な返事（へんじ）を選（えら）んでください。', 'Choose the most natural response to an opinion question.', '["はい、思（おも）いでした。","はい、私（わたし）もそう思（おも）います。","はい、そう言（い）いましたか。","いいえ、思（おも）ってください。"]', 1, '第（だい）21課（か）・即時応答（そくじおうとう）: そう思（おも）います naturally agrees with the prediction.', '明日（あした）は雨（あめ）が降（ふ）ると思（おも）いますか。'),
('n5-s1-q65', 'n5-set-1', 'N5', 'listening', TRUE, 65, 'いちばん自然（しぜん）な返事（へんじ）を選（えら）んでください。', 'Choose the response that identifies the modified noun.', '["父（ちち）がくれた時計（とけい）です。","はい、買（か）います。","いいえ、ありません。","三時（さんじ）です。"]', 0, '第（だい）22課（か）・即時応答（そくじおうとう）: The answer identifies the item with a noun-modifying clause.', 'どれがあなたのものですか。'),
('n5-s1-q66', 'n5-set-1', 'N5', 'listening', TRUE, 66, 'いちばん自然（しぜん）な返事（へんじ）を選（えら）んでください。', 'Choose the response describing the result.', '["昨日（きのう）しました。","三人（さんにん）です。","七時（しちじ）からです。","切符（きっぷ）が出（で）ます。"]', 3, '第（だい）23課（か）・即時応答（そくじおうとう）: The response states what happens as a result.', 'このボタンを押（お）すと、どうなりますか。'),
('n5-s1-q67', 'n5-set-1', 'N5', 'listening', TRUE, 67, 'いちばん自然（しぜん）な返事（へんじ）を選（えら）んでください。', 'Choose the response naming the helper.', '["兄（あに）に手伝（てつだ）います。","兄（あに）で手伝（てつだ）いません。","兄（あに）が手伝（てつだ）ってくれました。","兄（あに）を手伝（てつだ）いましたか。"]', 2, '第（だい）24課（か）・即時応答（そくじおうとう）: The が-marked person is the giver of the helpful action.', 'だれが手伝（てつだ）ってくれましたか。'),
('n5-s2-q1', 'n5-set-2', 'N5', 'vocabulary', TRUE, 1, '駅（えき）まで＿＿で行（い）きます。', 'I go to the station by bicycle.', '["じてんしゃ","でんわ","つくえ","くるまや"]', 0, '第（だい）5課（か）・文脈語彙（ぶんみゃくごい）: じてんしゃ means bicycle.', NULL),
('n5-s2-q2', 'n5-set-2', 'N5', 'vocabulary', TRUE, 2, '今日（きょう）は天気（てんき）が＿＿です。', 'The weather is good today.', '["いい","おおきい","ながい","あまい"]', 0, '第（だい）8課（か）・文脈語彙（ぶんみゃくごい）: いい means good and is used for weather.', NULL),
('n5-s2-q3', 'n5-set-2', 'N5', 'grammar-reading', TRUE, 3, '机（つくえ）の上（うえ）＿＿本（ほん）があります。', 'There is a book on the desk.', '["に","を","へ","と"]', 0, '第（だい）10課（か）・文法形式（ぶんぽうけいしき）: に marks the location where something exists.', NULL),
('n5-s2-q4', 'n5-set-2', 'N5', 'grammar-reading', TRUE, 4, '山田（やまだ）さんは魚（さかな）を食（た）べません。肉（にく）＿＿食（た）べません。', 'Yamada does not eat fish. He does not eat meat either.', '["も","は","で","へ"]', 0, '第（だい）9課（か）・文法形式（ぶんぽうけいしき）: も means ‘also’ or ‘either’ in a negative sentence.', NULL),
('n5-s2-q5', 'n5-set-2', 'N5', 'listening', TRUE, 5, '二人（ふたり）はどこで会（あ）いますか。', 'Where will the two people meet?', '["学校（がっこう）","駅（えき）","図書館（としょかん）","公園（こうえん）"]', 1, '第（だい）5課（か）・課題理解（かだいりかい）: They agree to meet at the station, 駅（えき）.', '三時（さんじ）に駅（えき）の前（まえ）で会（あ）いましょう。'),
('n5-s2-q6', 'n5-set-2', 'N5', 'listening', TRUE, 6, '男（おとこ）の人（ひと）は何曜日（なんようび）に休（やす）みますか。', 'Which day will the man take off?', '["月曜日（げつようび）","火曜日（かようび）","木曜日（もくようび）","金曜日（きんようび）"]', 2, '第（だい）4課（か）・要点理解（ようてんりかい）: The man says Thursday, 木曜日（もくようび）.', '今週（こんしゅう）は木曜日（もくようび）に休（やす）みます。'),
('n5-s2-q7', 'n5-set-2', 'N5', 'vocabulary', TRUE, 7, '今日（きょう）は天気がいいです。
「天気」の読（よ）み方（かた）を選（えら）んでください。', 'Choose the reading of 天気.', '["てんき","でんき","てんぎ","てんけ"]', 0, '第（だい）8課（か）・漢字読（かんじよ）み: 「天気」は「てんき」と読（よ）みます。', NULL),
('n5-s2-q8', 'n5-set-2', 'N5', 'vocabulary', TRUE, 8, '毎日（まいにち）、魚（さかな）を食べます。
「食」の読（よ）み方（かた）を選（えら）んでください。', 'Choose the reading of 食.', '["の","み","か","た"]', 3, '第（だい）6課（か）・漢字読（かんじよ）み: 「食」は「た」と読（よ）みます。', NULL),
('n5-s2-q9', 'n5-set-2', 'N5', 'vocabulary', TRUE, 9, '水（みず）を飲みます。
「飲」の読（よ）み方（かた）を選（えら）んでください。', 'Choose the reading of 飲.', '["よ","やす","の","た"]', 2, '第（だい）6課（か）・漢字読（かんじよ）み: 「飲」は「の」と読（よ）みます。', NULL),
('n5-s2-q10', 'n5-set-2', 'N5', 'vocabulary', TRUE, 10, '明日（あした）は会社（かいしゃ）を休みます。
「休」の読（よ）み方（かた）を選（えら）んでください。', 'Choose the reading of 休.', '["かえ","やす","のみ","よみ"]', 1, '第（だい）4課（か）・漢字読（かんじよ）み: 「休」は「やす」と読（よ）みます。', NULL),
('n5-s2-q11', 'n5-set-2', 'N5', 'vocabulary', TRUE, 11, '父（ちち）は会社で働（はたら）きます。
「会社」の読（よ）み方（かた）を選（えら）んでください。', 'Choose the reading of 会社.', '["かいしゃ","がいしゃ","かいじゃ","かいしや"]', 0, '第（だい）3課（か）・漢字読（かんじよ）み: 「会社」は「かいしゃ」と読（よ）みます。', NULL),
('n5-s2-q12', 'n5-set-2', 'N5', 'vocabulary', TRUE, 12, '午前に日本語（にほんご）を勉強（べんきょう）します。
「午前」の読（よ）み方（かた）を選（えら）んでください。', 'Choose the reading of 午前.', '["ごせん","こぜん","ごまえ","ごぜん"]', 3, '第（だい）4課（か）・漢字読（かんじよ）み: 「午前」は「ごぜん」と読（よ）みます。', NULL),
('n5-s2-q13', 'n5-set-2', 'N5', 'vocabulary', TRUE, 13, '家族は四人（よにん）です。
「家族」の読（よ）み方（かた）を選（えら）んでください。', 'Choose the reading of 家族.', '["いえぞく","かずく","かぞく","かそく"]', 2, '第（だい）11課（か）・漢字読（かんじよ）み: 「家族」は「かぞく」と読（よ）みます。', NULL),
('n5-s2-q14', 'n5-set-2', 'N5', 'vocabulary', TRUE, 14, '『さかな』を食（た）べます。
『さかな』の漢字（かんじ）を選（えら）んでください。', 'Choose the kanji for さかな.', '["車","魚","雨","電"]', 1, '第（だい）6課（か）・表記（ひょうき）: 『さかな』は「魚」と書（か）きます。', NULL),
('n5-s2-q15', 'n5-set-2', 'N5', 'vocabulary', TRUE, 15, '『あさ』六時（ろくじ）に起（お）きます。
『あさ』の漢字（かんじ）を選（えら）んでください。', 'Choose the kanji for あさ.', '["朝","昼","夜","夕"]', 0, '第（だい）4課（か）・表記（ひょうき）: 『あさ』は「朝」と書（か）きます。', NULL),
('n5-s2-q16', 'n5-set-2', 'N5', 'vocabulary', TRUE, 16, '『よる』十一時（じゅういちじ）に寝（ね）ます。
『よる』の漢字（かんじ）を選（えら）んでください。', 'Choose the kanji for よる.', '["朝","昼","外","夜"]', 3, '第（だい）4課（か）・表記（ひょうき）: 『よる』は「夜」と書（か）きます。', NULL),
('n5-s2-q17', 'n5-set-2', 'N5', 'vocabulary', TRUE, 17, '『でんしゃ』で行（い）きます。
『でんしゃ』の漢字（かんじ）を選（えら）んでください。', 'Choose the kanji for でんしゃ.', '["自車","電気","電車","電話"]', 2, '第（だい）5課（か）・表記（ひょうき）: 『でんしゃ』は「電車」と書（か）きます。', NULL),
('n5-s2-q18', 'n5-set-2', 'N5', 'vocabulary', TRUE, 18, '店（みせ）は駅（えき）の『まえ』です。
『まえ』の漢字（かんじ）を選（えら）んでください。', 'Choose the kanji for まえ.', '["下","前","後","上"]', 1, '第（だい）3課（か）・表記（ひょうき）: 『まえ』は「前」と書（か）きます。', NULL),
('n5-s2-q19', 'n5-set-2', 'N5', 'vocabulary', TRUE, 19, '薬（くすり）は＿＿で買（か）います。', 'Choose the word that best completes the sentence.', '["薬局（やっきょく）","喫茶店（きっさてん）","教室（きょうしつ）","公園（こうえん）"]', 0, '第（だい）3課（か）・文脈語彙（ぶんみゃくごい）: 薬局（やっきょく） sells medicine.', NULL),
('n5-s2-q20', 'n5-set-2', 'N5', 'vocabulary', TRUE, 20, '毎朝（まいあさ）、新聞（しんぶん）を＿＿。', 'Choose the word that best completes the sentence.', '["聞（き）きます","会（あ）います","撮（と）ります","読（よ）みます"]', 3, '第（だい）6課（か）・文脈語彙（ぶんみゃくごい）: 新聞（しんぶん） is read with 読（よ）みます.', NULL),
('n5-s2-q21', 'n5-set-2', 'N5', 'vocabulary', TRUE, 21, '弟（おとうと）は歌（うた）が＿＿です。とてもきれいに歌（うた）います。', 'Choose the word that best completes the sentence.', '["下手（へた）","暇（ひま）","上手（じょうず）","嫌（きら）い"]', 2, '第（だい）9課（か）・文脈語彙（ぶんみゃくごい）: 上手（じょうず） means skillful.', NULL),
('n5-s2-q22', 'n5-set-2', 'N5', 'vocabulary', TRUE, 22, '日本（にほん）に＿＿いますか。三年（さんねん）います。', 'Choose the word that best completes the sentence.', '["どちら","どのくらい","いくつ","いくら"]', 1, '第（だい）11課（か）・文脈語彙（ぶんみゃくごい）: どのくらい asks duration.', NULL),
('n5-s2-q23', 'n5-set-2', 'N5', 'vocabulary', TRUE, 23, '仕事（しごと）は五時（ごじ）に終（お）わります。
同（おな）じ意味（いみ）の文（ぶん）を選（えら）んでください。', 'Choose the sentence with the same meaning.', '["五時（ごじ）から仕事（しごと）をしません。","五時（ごじ）まで仕事（しごと）をします。","五時（ごじ）に仕事（しごと）を始（はじ）めます。","五時（ごじ）から五時間（ごじかん）働（はたら）きます。"]', 0, '第（だい）4課（か）・言（い）い換（か）え: Ending at five means working until five.', NULL),
('n5-s2-q24', 'n5-set-2', 'N5', 'vocabulary', TRUE, 24, '一人（ひとり）で旅行（りょこう）します。
同（おな）じ意味（いみ）の文（ぶん）を選（えら）んでください。', 'Choose the sentence with the same meaning.', '["家族（かぞく）と旅行（りょこう）します。","二人（ふたり）で旅行（りょこう）します。","旅行（りょこう）しません。","だれとも旅行（りょこう）しません。"]', 3, '第（だい）5課（か）・言（い）い換（か）え: 一人（ひとり）で means alone.', NULL),
('n5-s2-q25', 'n5-set-2', 'N5', 'vocabulary', TRUE, 25, '一週間（いっしゅうかん）に二回（にかい）泳（およ）ぎます。
同（おな）じ意味（いみ）の文（ぶん）を選（えら）んでください。', 'Choose the sentence with the same meaning.', '["毎日（まいにち）二回（にかい）泳（およ）ぎます。","一週間（いっしゅうかん）泳（およ）ぎません。","毎週（まいしゅう）二回（にかい）泳（およ）ぎます。","二週間（にしゅうかん）泳（およ）ぎます。"]', 2, '第（だい）11課（か）・言（い）い換（か）え: 一週間（いっしゅうかん）に means per week.', NULL),
('n5-s2-q26', 'n5-set-2', 'N5', 'grammar-reading', TRUE, 26, '＿＿は傘（かさ）です。私（わたし）の近（ちか）くにあります。', 'This near me is a umbrella.', '["どれ","これ","この","ここ"]', 1, '第（だい）2課（か）・文法形式（ぶんぽうけいしき）: これ refers to a thing near the speaker and stands alone.', NULL),
('n5-s2-q27', 'n5-set-2', 'N5', 'grammar-reading', TRUE, 27, '山田（やまだ）は九時（くじ）＿＿起（お）きます。', '山田（やまだ） gets up at 九時（くじ）.', '["に","で","を","へ"]', 0, '第（だい）4課（か）・文法形式（ぶんぽうけいしき）: に marks a specific time.', NULL),
('n5-s2-q28', 'n5-set-2', 'N5', 'grammar-reading', TRUE, 28, '日本語（にほんご）＿＿手紙（てがみ）を書（か）きます。', 'I write a letter in Japanese.', '["を","に","へ","で"]', 3, '第（だい）7課（か）・文法形式（ぶんぽうけいしき）: で marks the language or means used.', NULL),
('n5-s2-q29', 'n5-set-2', 'N5', 'grammar-reading', TRUE, 29, '駅（えき）＿＿木村（きむら）がいます。', '木村（きむら） is at the 駅（えき）.', '["で","へ","に","を"]', 2, '第（だい）10課（か）・文法形式（ぶんぽうけいしき）: に marks the place where a person exists.', NULL),
('n5-s2-q30', 'n5-set-2', 'N5', 'grammar-reading', TRUE, 30, 'すみません。窓（まど）を閉（し）めて＿＿。', 'Please do the requested action.', '["なります","ください","います","あります"]', 1, '第（だい）14課（か）・文法形式（ぶんぽうけいしき）: The て-form plus ください makes a polite request.', NULL),
('n5-s2-q31', 'n5-set-2', 'N5', 'grammar-reading', TRUE, 31, '明日（あした）までに薬（くすり）を飲（の）まなければ＿＿。', 'The action must be completed by tomorrow.', '["なりません","ありません","いけます","ください"]', 0, '第（だい）17課（か）・文法形式（ぶんぽうけいしき）: ない-form without い + ければなりません expresses obligation.', NULL),
('n5-s2-q32', 'n5-set-2', 'N5', 'grammar-reading', TRUE, 32, '雨（あめ）が＿＿、家（いえ）にいます。', 'Choose the たら conditional form.', '["降（ふ）っても","降（ふ）りますから","降（ふ）るまで","降（ふ）ったら"]', 3, '第（だい）25課（か）・文法形式（ぶんぽうけいしき）: The たら form expresses a condition for the following action.', NULL),
('n5-s2-q33', 'n5-set-2', 'N5', 'grammar-reading', TRUE, 33, '一日（いちにち）の順番（じゅんばん）として正（ただ）しい文（ぶん）はどれですか。', 'Choose the correctly formed sentence.', '["会社（かいしゃ）へ行（い）って、仕事（しごと）をするて、家（いえ）へ帰（かえ）ります。","会社（かいしゃ）へ行（い）くて、仕事（しごと）をして、家（いえ）へ帰（かえ）ります。","会社（かいしゃ）へ行（い）って、仕事（しごと）をして、家（いえ）へ帰（かえ）ります。","会社（かいしゃ）へ行（い）きて、仕事（しごと）をして、家（いえ）へ帰（かえ）ります。"]', 2, '第（だい）16課（か）・文（ぶん）の組（く）み立（た）て: て-forms connect actions in chronological order.', NULL)
ON DUPLICATE KEY UPDATE
  set_id = VALUES(set_id),
  level = VALUES(level),
  section = VALUES(section),
  active = VALUES(active),
  order_no = VALUES(order_no),
  prompt = VALUES(prompt),
  prompt_en = VALUES(prompt_en),
  options = VALUES(options),
  answer_index = VALUES(answer_index),
  explanation = VALUES(explanation),
  audio_text = VALUES(audio_text),
  updated_at = CURRENT_TIMESTAMP(3);

INSERT INTO questions
  (id, set_id, level, section, active, order_no, prompt, prompt_en, options, answer_index, explanation, audio_text)
VALUES
('n5-s2-q34', 'n5-set-2', 'N5', 'grammar-reading', TRUE, 34, '正（ただ）しい文（ぶん）を選（えら）んでください。', 'Choose the correctly formed sentence.', '["食事（しょくじ）で前（まえ）に、手（て）を洗（あら）います。","食事（しょくじ）の前（まえ）に、手（て）を洗（あら）います。","食事（しょくじ）する前（まえ）に、手（て）を洗（あら）います。","食事（しょくじ）を前（まえ）に、手（て）を洗（あら）います。"]', 1, '第（だい）18課（か）・文（ぶん）の組（く）み立（た）て: Noun + の + 前（まえ）に is used before an event.', NULL),
('n5-s2-q35', 'n5-set-2', 'N5', 'grammar-reading', TRUE, 35, '週末（しゅうまつ）の活動（かつどう）として正（ただ）しい文（ぶん）はどれですか。', 'Choose the correctly formed sentence.', '["本（ほん）を読（よ）んだり、音楽（おんがく）を聞（き）いたりします。","本（ほん）を読（よ）んでり、音楽（おんがく）を聞（き）いてりします。","本（ほん）を読（よ）むたり、音楽（おんがく）を聞（き）くたりします。","本（ほん）を読（よ）みたり、音楽（おんがく）を聞（き）きたりです。"]', 0, '第（だい）19課（か）・文（ぶん）の組（く）み立（た）て: た-form + り lists representative activities.', NULL),
('n5-s2-q36', 'n5-set-2', 'N5', 'grammar-reading', TRUE, 36, '聞（き）いたことを伝（つた）える正（ただ）しい文（ぶん）はどれですか。', 'Choose the correctly formed sentence.', '["先生（せんせい）は明日（あした）休（やす）みますと言（い）いました。","先生（せんせい）は明日（あした）休（やす）んでと言（い）いました。","先生（せんせい）は明日（あした）休（やす）むを言（い）いました。","先生（せんせい）は明日（あした）休（やす）むと言（い）いました。"]', 3, '第（だい）21課（か）・文（ぶん）の組（く）み立（た）て: Plain form + と言（い）いました reports speech.', NULL),
('n5-s2-q37', 'n5-set-2', 'N5', 'grammar-reading', TRUE, 37, '兄（あに）が弟（おとうと）に聞（き）きました。『もう宿題（しゅくだい）を＿＿？』', 'Choose the grammar that best completes the text.', '["して","するでした","した","しました"]', 2, '第（だい）20課（か）・文章文法（ぶんしょうぶんぽう）: Casual past questions use the plain past form.', NULL),
('n5-s2-q38', 'n5-set-2', 'N5', 'grammar-reading', TRUE, 38, '日本（にほん）へ来（き）た＿＿、まだ日本語（にほんご）が分（わ）かりませんでした。', 'Choose the grammar that best completes the text.', '["まで","とき","まえ","あとで"]', 1, '第（だい）23課（か）・文章文法（ぶんしょうぶんぽう）: Past form + とき describes the time after arriving.', NULL),
('n5-s2-q39', 'n5-set-2', 'N5', 'grammar-reading', TRUE, 39, '重（おも）い荷物（にもつ）を持（も）っていたら、姉（あね）が手伝（てつだ）って＿＿。', 'Choose the grammar that best completes the text.', '["くれました","もらいました","あげました","しました"]', 0, '第（だい）24課（か）・文章文法（ぶんしょうぶんぽう）: て-form + くれました describes someone helping the speaker.', NULL),
('n5-s2-q40', 'n5-set-2', 'N5', 'grammar-reading', TRUE, 40, '短（みじか）い文章（ぶんしょう）を読（よ）んでください。
山田（やまだ）さんは九時（くじ）から五時（ごじ）まで働（はたら）きます。昼休（ひるやす）みは十二時（じゅうにじ）から一時（いちじ）までです。
山田（やまだ）さんの昼休（ひるやす）みは何時間（なんじかん）ですか。', 'Yamada works 9–5 and has lunch from 12–1. How long is lunch?', '["二時間（にじかん）","四時間（よじかん）","八時間（はちじかん）","一時間（いちじかん）"]', 3, '第（だい）4課（か）・読解（どっかい）: From noon to one is one hour.', NULL),
('n5-s2-q41', 'n5-set-2', 'N5', 'grammar-reading', TRUE, 41, 'メールを読（よ）んでください。
木村（きむら）さんへ
来週（らいしゅう）の土曜日（どようび）、大阪（おおさか）へ行（い）きます。朝（あさ）八時（はちじ）の電車（でんしゃ）です。駅（えき）で会（あ）いましょう。
山田（やまだ）
山田（やまだ）さんはいつ大阪（おおさか）へ行（い）きますか。', 'Yamada says he is taking the 8:00 train to Osaka next Saturday. When will he go?', '["来週（らいしゅう）の日曜日（にちようび）","今日（きょう）の朝（あさ）","来週（らいしゅう）の土曜日（どようび）","今週（こんしゅう）の土曜日（どようび）"]', 2, '第（だい）5課（か）・読解（どっかい）: The email says next Saturday.', NULL),
('n5-s2-q42', 'n5-set-2', 'N5', 'grammar-reading', TRUE, 42, '食堂（しょくどう）のメニュー
カレー：六百円（ろっぴゃくえん）
うどん：五百円（ごひゃくえん）
そば：五百五十円（ごひゃくごじゅうえん）
水（みず）：無料（むりょう）
五百円（ごひゃくえん）で買（か）えるものはどれですか。', 'The menu lists curry 600 yen, udon 500, soba 550, and water free. What can be bought for 500 yen?', '["カレーと水（みず）","うどん","カレー","そば"]', 1, '第（だい）11課（か）・読解（どっかい）: Udon costs exactly 500 yen.', NULL),
('n5-s2-q43', 'n5-set-2', 'N5', 'grammar-reading', TRUE, 43, '電車（でんしゃ）はバスより速（はや）いですが、バスより高（たか）いです。バスは時間（じかん）がかかりますが、安（やす）いです。
正（ただ）しい文（ぶん）はどれですか。', 'The train is faster but more expensive than the bus. Which sentence is correct?', '["バスは電車（でんしゃ）より安（やす）いです。","バスは電車（でんしゃ）より速（はや）いです。","電車（でんしゃ）はバスより安（やす）いです。","電車（でんしゃ）とバスは同（おな）じです。"]', 0, '第（だい）12課（か）・読解（どっかい）: The passage states that the bus is cheaper.', NULL),
('n5-s2-q44', 'n5-set-2', 'N5', 'grammar-reading', TRUE, 44, 'あそこにいる白（しろ）い帽子（ぼうし）をかぶっている人（ひと）は私（わたし）の先生（せんせい）です。黒（くろ）い帽子（ぼうし）の人（ひと）は兄（あに）です。
先生（せんせい）はどの人（ひと）ですか。', 'The person wearing a white hat is my teacher; the person with a black hat is my brother. Who is the teacher?', '["黒（くろ）い帽子（ぼうし）の人（ひと）","帽子（ぼうし）がない人（ひと）","赤（あか）い服（ふく）の人（ひと）","白（しろ）い帽子（ぼうし）の人（ひと）"]', 3, '第（だい）22課（か）・読解（どっかい）: The teacher is described by the white hat.', NULL),
('n5-s2-q45', 'n5-set-2', 'N5', 'grammar-reading', TRUE, 45, '病院（びょういん）からのお知（し）らせ
予約（よやく）は前（まえ）の日（ひ）までにしなければなりません。病院（びょういん）の中（なか）で電話（でんわ）を使（つか）わないでください。
正（ただ）しいことはどれですか。', 'The hospital requires reservations by the previous day and prohibits phone use inside. Which is correct?', '["予約（よやく）はいりません。","病院（びょういん）は毎日（まいにち）休（やす）みです。","予約（よやく）は前（まえ）の日（ひ）までにします。","病院（びょういん）で電話（でんわ）を使（つか）ってもいいです。"]', 2, '第（だい）17課（か）・読解（どっかい）: The notice requires booking by the previous day.', NULL),
('n5-s2-q46', 'n5-set-2', 'N5', 'listening', TRUE, 46, '女（おんな）の人（ひと）はどこへ行（い）きますか。', 'Listen and choose what the person will do.', '["喫茶店（きっさてん）","薬局（やっきょく）","本屋（ほんや）","銀行（ぎんこう）"]', 1, '第（だい）3課（か）・課題理解（かだいりかい）: She goes to the pharmacy to buy medicine.', '頭（あたま）が痛（いた）いですから、薬（くすり）を買（か）いに薬局（やっきょく）へ行（い）きます。'),
('n5-s2-q47', 'n5-set-2', 'N5', 'listening', TRUE, 47, '男（おとこ）の人（ひと）は何（なに）で会社（かいしゃ）へ行（い）きますか。', 'Listen and choose what the person will do.', '["電車（でんしゃ）","バス","自転車（じてんしゃ）","車（くるま）"]', 0, '第（だい）5課（か）・課題理解（かだいりかい）: He will take the train.', '道（みち）が込（こ）んでいますから、車（くるま）では行（い）きません。今日（きょう）は電車（でんしゃ）で会社（かいしゃ）へ行（い）きます。'),
('n5-s2-q48', 'n5-set-2', 'N5', 'listening', TRUE, 48, '男（おとこ）の人（ひと）は友達（ともだち）に何（なに）を貸（か）しますか。', 'Listen and choose what the person will do.', '["本（ほん）","自転車（じてんしゃ）","辞書（じしょ）","傘（かさ）"]', 3, '第（だい）7課（か）・課題理解（かだいりかい）: He lends an umbrella.', '雨（あめ）が降（ふ）っていますね。この傘（かさ）を使（つか）ってください。'),
('n5-s2-q49', 'n5-set-2', 'N5', 'listening', TRUE, 49, '男（おとこ）の人（ひと）はパンをいくつ買（か）いますか。', 'Listen and choose what the person will do.', '["三（みっ）つ","五（いつ）つ","四（よっ）つ","二（ふた）つ"]', 2, '第（だい）11課（か）・課題理解（かだいりかい）: He buys four pieces of bread.', '家族（かぞく）は四人（よにん）ですから、パンを四（よっ）つ買（か）います。'),
('n5-s2-q50', 'n5-set-2', 'N5', 'listening', TRUE, 50, '女（おんな）の人（ひと）は何（なに）をしに図書館（としょかん）へ行（い）きますか。', 'Listen and choose what the person will do.', '["友達（ともだち）を待（ま）ちます","勉強（べんきょう）します","寝（ね）ます","食事（しょくじ）します"]', 1, '第（だい）13課（か）・課題理解（かだいりかい）: She goes to study for a test.', '明日（あした）は試験（しけん）ですから、図書館（としょかん）へ勉強（べんきょう）しに行（い）きます。'),
('n5-s2-q51', 'n5-set-2', 'N5', 'listening', TRUE, 51, '電車（でんしゃ）は何時（なんじ）に出（で）ますか。', 'Listen and choose the key detail.', '["九時十五分（くじじゅうごふん）","九時（くじ）","九時半（くじはん）","十時十五分（じゅうじじゅうごふん）"]', 0, '第（だい）4課（か）・要点理解（ようてんりかい）: The next train is at 9:15.', '九時（くじ）の電車（でんしゃ）はもう出（で）ました。次（つぎ）は九時十五分（くじじゅうごふん）です。'),
('n5-s2-q52', 'n5-set-2', 'N5', 'listening', TRUE, 52, '男（おとこ）の人（ひと）は何（なに）を飲（の）みますか。', 'Listen and choose the key detail.', '["水（みず）","コーヒー","ジュース","お茶（ちゃ）"]', 3, '第（だい）6課（か）・要点理解（ようてんりかい）: He asks for tea.', 'コーヒーは朝（あさ）飲（の）みました。今（いま）はお茶（ちゃ）をください。'),
('n5-s2-q53', 'n5-set-2', 'N5', 'listening', TRUE, 53, '女（おんな）の人（ひと）はどの部屋（へや）が好（す）きですか。', 'Listen and choose the key detail.', '["明（あか）るい部屋（へや）","新（あたら）しい部屋（へや）","静（しず）かな部屋（へや）","広（ひろ）い部屋（へや）"]', 2, '第（だい）8課（か）・要点理解（ようてんりかい）: Quietness is her preference.', '広（ひろ）くなくてもいいです。静（しず）かな部屋（へや）が好（す）きです。'),
('n5-s2-q54', 'n5-set-2', 'N5', 'listening', TRUE, 54, '男（おとこ）の人（ひと）はどうして料理（りょうり）が上手（じょうず）ですか。', 'Listen and choose the key detail.', '["料理（りょうり）が嫌（きら）いですから","毎日（まいにち）作（つく）りますから","レストランで働（はたら）きますから","母（はは）が作（つく）りますから"]', 1, '第（だい）9課（か）・要点理解（ようてんりかい）: He cooks every day.', '一人（ひとり）で住（す）んでいて、毎日（まいにち）料理（りょうり）を作（つく）りますから、上手（じょうず）になりました。'),
('n5-s2-q55', 'n5-set-2', 'N5', 'listening', TRUE, 55, '昨日（きのう）の試験（しけん）はどうでしたか。', 'Listen and choose the key detail.', '["難（むずか）しかったです","簡単（かんたん）でした","長（なが）くなかったです","面白（おもしろ）かったです"]', 0, '第（だい）12課（か）・要点理解（ようてんりかい）: The test was difficult.', 'たくさん勉強（べんきょう）しましたが、昨日（きのう）の試験（しけん）は難（むずか）しかったです。'),
('n5-s2-q56', 'n5-set-2', 'N5', 'listening', TRUE, 56, '初（はじ）めて会（あ）う人（ひと）に何（なん）と言（い）いますか。', 'What do you say when meeting someone for the first time?', '["いただきます。","お帰（かえ）りなさい。","お大事（だいじ）に。","初（はじ）めまして。"]', 3, '第（だい）1課（か）・発話表現（はつわひょうげん）: 初（はじ）めまして is used at a first meeting.', 'あなたはネパールから来（き）ました。初（はじ）めて山田（やまだ）に会（あ）います。何（なん）と言（い）いますか。'),
('n5-s2-q57', 'n5-set-2', 'N5', 'listening', TRUE, 57, '店（みせ）で値段（ねだん）を聞（き）きます。何（なん）と言（い）いますか。', 'What do you say to ask the price in a shop?', '["その傘（かさ）はだれですか。","その傘（かさ）はいつですか。","その傘（かさ）はいくらですか。","その傘（かさ）はどこですか。"]', 2, '第（だい）2課（か）・発話表現（はつわひょうげん）: いくら asks a price.', '店（みせ）でその傘（かさ）の値段（ねだん）を知（し）りたいです。何（なん）と言（い）いますか。'),
('n5-s2-q58', 'n5-set-2', 'N5', 'listening', TRUE, 58, '丁寧（ていねい）にお願（ねが）いします。何（なん）と言（い）いますか。', 'Which expression makes the polite request?', '["ドアを開（あ）けるたいです。","ドアを開（あ）けてください。","ドアを開（あ）けるません。","ドアを開（あ）けることがあります。"]', 1, '第（だい）14課（か）・発話表現（はつわひょうげん）: The て-form plus ください makes a polite request.', '木村（きむら）にドアを開（あ）けることをお願（ねが）いします。何（なん）と言（い）いますか。'),
('n5-s2-q59', 'n5-set-2', 'N5', 'listening', TRUE, 59, '許可（きょか）を聞（き）きます。何（なん）と言（い）いますか。', 'What do you say to ask permission?', '["あの椅子（いす）に座（すわ）ってもいいですか。","あの椅子（いす）に座（すわ）ってはいけません。","あの椅子（いす）に座（すわ）らないでください。","あの椅子（いす）に座（すわ）らなければなりません。"]', 0, '第（だい）15課（か）・発話表現（はつわひょうげん）: て-form + もいいですか asks permission.', 'あの椅子（いす）に座（すわ）りたいです。先生（せんせい）に何（なん）と言（い）いますか。'),
('n5-s2-q60', 'n5-set-2', 'N5', 'listening', TRUE, 60, '手伝（てつだ）いを申（もう）し出（で）ます。何（なん）と言（い）いますか。', 'What do you say to offer help?', '["この箱（はこ）を持（も）ってはいけません。","この箱（はこ）を持（も）ちたいですか。","この箱（はこ）を持（も）たないでください。","この箱（はこ）を持（も）ちましょうか。"]', 3, '第（だい）16課（か）・発話表現（はつわひょうげん）: Verb stem + ましょうか can offer assistance.', '山田（やまだ）がこの箱（はこ）を運（はこ）んでいます。手伝（てつだ）いたいです。何（なん）と言（い）いますか。'),
('n5-s2-q61', 'n5-set-2', 'N5', 'listening', TRUE, 61, '友達（ともだち）の助（たす）けにお礼（れい）を言（い）います。何（なん）と言（い）いますか。', 'What do you say to thank a friend for helping?', '["日本語（にほんご）を教（おし）えてくださいか。","日本語（にほんご）を教（おし）えてありません。","日本語（にほんご）を教（おし）えてくれて、ありがとう。","日本語（にほんご）を教（おし）えてはいけません。"]', 2, '第（だい）24課（か）・発話表現（はつわひょうげん）: てくれてありがとう thanks someone for a helpful action.', '木村（きむら）が日本語（にほんご）を教（おし）えてくれました。何（なん）と言（い）いますか。'),
('n5-s2-q62', 'n5-set-2', 'N5', 'listening', TRUE, 62, 'いちばん自然（しぜん）な返事（へんじ）を選（えら）んでください。', 'Choose the most natural response.', '["いいえ、します。","はい、あります。","はい、います。","いいえ、ありませんでしたか。"]', 1, '第（だい）19課（か）・即時応答（そくじおうとう）: はい、あります answers an experience question.', '着物（きもの）を着（き）たことがありますか。'),
('n5-s2-q63', 'n5-set-2', 'N5', 'listening', TRUE, 63, 'いちばん自然（しぜん）な返事（へんじ）を選（えら）んでください。', 'Choose the most natural casual response.', '["うん、いいよ。","はい、いいですか。","いいえ、行（い）きました。","うん、ありません。"]', 0, '第（だい）20課（か）・即時応答（そくじおうとう）: うん、いいよ is a natural casual acceptance.', '今晩（こんばん）、一緒（いっしょ）にご飯（はん）を食（た）べる？'),
('n5-s2-q64', 'n5-set-2', 'N5', 'listening', TRUE, 64, 'いちばん自然（しぜん）な返事（へんじ）を選（えら）んでください。', 'Choose the most natural response to an opinion question.', '["はい、そう言（い）いましたか。","いいえ、思（おも）ってください。","はい、思（おも）いでした。","はい、私（わたし）もそう思（おも）います。"]', 3, '第（だい）21課（か）・即時応答（そくじおうとう）: そう思（おも）います naturally agrees with the prediction.', '電車（でんしゃ）が遅（おく）れると思（おも）いますか。'),
('n5-s2-q65', 'n5-set-2', 'N5', 'listening', TRUE, 65, 'いちばん自然（しぜん）な返事（へんじ）を選（えら）んでください。', 'Choose the response that identifies the modified noun.', '["いいえ、ありません。","三時（さんじ）です。","昨日（きのう）買（か）ったかばんです。","はい、買（か）います。"]', 2, '第（だい）22課（か）・即時応答（そくじおうとう）: The answer identifies the item with a noun-modifying clause.', 'どれがあなたのものですか。'),
('n5-s2-q66', 'n5-set-2', 'N5', 'listening', TRUE, 66, 'いちばん自然（しぜん）な返事（へんじ）を選（えら）んでください。', 'Choose the response describing the result.', '["七時（しちじ）からです。","お金（かね）が出（で）ます。","昨日（きのう）しました。","三人（さんにん）です。"]', 1, '第（だい）23課（か）・即時応答（そくじおうとう）: The response states what happens as a result.', 'このカードを入（い）れると、どうなりますか。'),
('n5-s2-q67', 'n5-set-2', 'N5', 'listening', TRUE, 67, 'いちばん自然（しぜん）な返事（へんじ）を選（えら）んでください。', 'Choose the response naming the helper.', '["母（はは）が手伝（てつだ）ってくれました。","母（はは）を手伝（てつだ）いましたか。","母（はは）に手伝（てつだ）います。","母（はは）で手伝（てつだ）いません。"]', 0, '第（だい）24課（か）・即時応答（そくじおうとう）: The が-marked person is the giver of the helpful action.', 'だれが手伝（てつだ）ってくれましたか。'),
('n5-s3-q1', 'n5-set-3', 'N5', 'vocabulary', TRUE, 1, '寒（さむ）いですから、窓（まど）を＿＿ください。', 'It is cold, so please close the window.', '["しめて","あけて","つけて","けして"]', 0, '第（だい）14課（か）・文脈語彙（ぶんみゃくごい）: しめて is the て-form of しめる, ‘to close’.', NULL),
('n5-s3-q2', 'n5-set-3', 'N5', 'vocabulary', TRUE, 2, '母（はは）は台所（だいどころ）で料理（りょうり）を＿＿。', 'My mother makes food in the kitchen.', '["つくります","あらいます","かえります","ならいます"]', 0, '第（だい）6課（か）・文脈語彙（ぶんみゃくごい）: つくります means ‘makes’.', NULL),
('n5-s3-q3', 'n5-set-3', 'N5', 'grammar-reading', TRUE, 3, '日曜日（にちようび）に映画（えいが）を見（み）＿＿行（い）きませんか。', 'Would you like to go see a film on Sunday?', '["に","を","で","が"]', 0, '第（だい）13課（か）・文法形式（ぶんぽうけいしき）: Verb stem + に行（い）く expresses going somewhere for a purpose.', NULL),
('n5-s3-q4', 'n5-set-3', 'N5', 'grammar-reading', TRUE, 4, 'この部屋（へや）はあの部屋（へや）＿＿広（ひろ）いです。', 'This room is more spacious than that room.', '["より","まで","しか","から"]', 0, '第（だい）12課（か）・文法形式（ぶんぽうけいしき）: より marks the item used for comparison.', NULL),
('n5-s3-q5', 'n5-set-3', 'N5', 'listening', TRUE, 5, '先生（せんせい）は宿題（しゅくだい）をいつ出（だ）しますか。', 'When will the teacher assign the homework?', '["今日（きょう）","明日（あした）","金曜日（きんようび）","来週（らいしゅう）"]', 1, '第（だい）17課（か）・課題理解（かだいりかい）: The teacher says tomorrow, 明日（あした）.', '宿題（しゅくだい）は明日（あした）出（だ）します。金曜日（きんようび）までにしてください。'),
('n5-s3-q6', 'n5-set-3', 'N5', 'listening', TRUE, 6, '子供（こども）は何（なに）を飲（の）みますか。', 'What will the child drink?', '["水（みず）","お茶（ちゃ）","牛乳（ぎゅうにゅう）","ジュース"]', 2, '第（だい）7課（か）・要点理解（ようてんりかい）: The child chooses milk, 牛乳（ぎゅうにゅう）.', 'ジュースはありません。牛乳（ぎゅうにゅう）をください。'),
('n5-s3-q7', 'n5-set-3', 'N5', 'vocabulary', TRUE, 7, '北海道（ほっかいどう）は冬（ふゆ）とても寒いです。
「寒」の読（よ）み方（かた）を選（えら）んでください。', 'Choose the reading of 寒.', '["つめ","から","さむ","あつ"]', 2, '第（だい）8課（か）・漢字読（かんじよ）み: 「寒」は「さむ」と読（よ）みます。', NULL),
('n5-s3-q8', 'n5-set-3', 'N5', 'vocabulary', TRUE, 8, '母（はは）は台所にいます。
「台所」の読（よ）み方（かた）を選（えら）んでください。', 'Choose the reading of 台所.', '["だいどこ","だいどころ","たいところ","だいしょ"]', 1, '第（だい）10課（か）・漢字読（かんじよ）み: 「台所」は「だいどころ」と読（よ）みます。', NULL),
('n5-s3-q9', 'n5-set-3', 'N5', 'vocabulary', TRUE, 9, '父（ちち）は料理が上手（じょうず）です。
「料理」の読（よ）み方（かた）を選（えら）んでください。', 'Choose the reading of 料理.', '["りょうり","りょり","りょうに","りょおり"]', 0, '第（だい）6課（か）・漢字読（かんじよ）み: 「料理」は「りょうり」と読（よ）みます。', NULL),
('n5-s3-q10', 'n5-set-3', 'N5', 'vocabulary', TRUE, 10, '日曜日（にちようび）に映画を見（み）たいです。
「映画」の読（よ）み方（かた）を選（えら）んでください。', 'Choose the reading of 映画.', '["えが","えいか","えんが","えいが"]', 3, '第（だい）13課（か）・漢字読（かんじよ）み: 「映画」は「えいが」と読（よ）みます。', NULL),
('n5-s3-q11', 'n5-set-3', 'N5', 'vocabulary', TRUE, 11, 'この部屋はあの部屋（へや）より広（ひろ）いです。
「部屋」の読（よ）み方（かた）を選（えら）んでください。', 'Choose the reading of 部屋.', '["へおく","ぶおく","へや","ぶや"]', 2, '第（だい）12課（か）・漢字読（かんじよ）み: 「部屋」は「へや」と読（よ）みます。', NULL),
('n5-s3-q12', 'n5-set-3', 'N5', 'vocabulary', TRUE, 12, '宿題は金曜日（きんようび）までです。
「宿題」の読（よ）み方（かた）を選（えら）んでください。', 'Choose the reading of 宿題.', '["しゅくだ","しゅくだい","しゅくたい","しくだい"]', 1, '第（だい）17課（か）・漢字読（かんじよ）み: 「宿題」は「しゅくだい」と読（よ）みます。', NULL),
('n5-s3-q13', 'n5-set-3', 'N5', 'vocabulary', TRUE, 13, '公園（こうえん）に子供がいます。
「子供」の読（よ）み方（かた）を選（えら）んでください。', 'Choose the reading of 子供.', '["こども","ことも","しきょう","こきょう"]', 0, '第（だい）10課（か）・漢字読（かんじよ）み: 「子供」は「こども」と読（よ）みます。', NULL),
('n5-s3-q14', 'n5-set-3', 'N5', 'vocabulary', TRUE, 14, '『にく』を買（か）います。
『にく』の漢字（かんじ）を選（えら）んでください。', 'Choose the kanji for にく.', '["内","人","入","肉"]', 3, '第（だい）6課（か）・表記（ひょうき）: 『にく』は「肉」と書（か）きます。', NULL),
('n5-s3-q15', 'n5-set-3', 'N5', 'vocabulary', TRUE, 15, '『ほん』を読（よ）みます。
『ほん』の漢字（かんじ）を選（えら）んでください。', 'Choose the kanji for ほん.', '["休","体","本","木"]', 2, '第（だい）2課（か）・表記（ひょうき）: 『ほん』は「本」と書（か）きます。', NULL),
('n5-s3-q16', 'n5-set-3', 'N5', 'vocabulary', TRUE, 16, '『まいにち』勉強（べんきょう）します。
『まいにち』の漢字（かんじ）を選（えら）んでください。', 'Choose the kanji for まいにち.', '["休日","毎日","毎月","今日"]', 1, '第（だい）4課（か）・表記（ひょうき）: 『まいにち』は「毎日」と書（か）きます。', NULL)
ON DUPLICATE KEY UPDATE
  set_id = VALUES(set_id),
  level = VALUES(level),
  section = VALUES(section),
  active = VALUES(active),
  order_no = VALUES(order_no),
  prompt = VALUES(prompt),
  prompt_en = VALUES(prompt_en),
  options = VALUES(options),
  answer_index = VALUES(answer_index),
  explanation = VALUES(explanation),
  audio_text = VALUES(audio_text),
  updated_at = CURRENT_TIMESTAMP(3);

INSERT INTO questions
  (id, set_id, level, section, active, order_no, prompt, prompt_en, options, answer_index, explanation, audio_text)
VALUES
('n5-s3-q17', 'n5-set-3', 'N5', 'vocabulary', TRUE, 17, '『がっこう』はここです。
『がっこう』の漢字（かんじ）を選（えら）んでください。', 'Choose the kanji for がっこう.', '["学校","会社","学生","校学"]', 0, '第（だい）3課（か）・表記（ひょうき）: 『がっこう』は「学校」と書（か）きます。', NULL),
('n5-s3-q18', 'n5-set-3', 'N5', 'vocabulary', TRUE, 18, '猫（ねこ）は机（つくえ）の『した』です。
『した』の漢字（かんじ）を選（えら）んでください。', 'Choose the kanji for した.', '["上","中","外","下"]', 3, '第（だい）10課（か）・表記（ひょうき）: 『した』は「下」と書（か）きます。', NULL),
('n5-s3-q19', 'n5-set-3', 'N5', 'vocabulary', TRUE, 19, '駅（えき）までバスに＿＿。', 'Choose the word that best completes the sentence.', '["曲（ま）がります","渡（わた）ります","乗（の）ります","降（お）ります"]', 2, '第（だい）5課（か）・文脈語彙（ぶんみゃくごい）: 乗（の）ります means board a vehicle.', NULL),
('n5-s3-q20', 'n5-set-3', 'N5', 'vocabulary', TRUE, 20, '先生（せんせい）に辞書（じしょ）を＿＿。', 'Choose the word that best completes the sentence.', '["書（か）きました","借（か）りました","貸（か）しました","あげました"]', 1, '第（だい）7課（か）・文脈語彙（ぶんみゃくごい）: 借（か）りました means borrowed.', NULL),
('n5-s3-q21', 'n5-set-3', 'N5', 'vocabulary', TRUE, 21, 'この部屋（へや）は＿＿です。掃除（そうじ）しました。', 'Choose the word that best completes the sentence.', '["きれい","嫌（きら）い","上手（じょうず）","元気（げんき）"]', 0, '第（だい）8課（か）・文脈語彙（ぶんみゃくごい）: きれい describes a clean room.', NULL),
('n5-s3-q22', 'n5-set-3', 'N5', 'vocabulary', TRUE, 22, '昨日（きのう）の試験（しけん）は＿＿。', 'Choose the word that best completes the sentence.', '["難（むずか）しいでした","難（むずか）くです","難（むずか）いです","難（むずか）しかったです"]', 3, '第（だい）12課（か）・文脈語彙（ぶんみゃくごい）: The past form of 難（むずか）しい is 難（むずか）しかったです.', NULL),
('n5-s3-q23', 'n5-set-3', 'N5', 'vocabulary', TRUE, 23, '先生（せんせい）に本（ほん）を借（か）りました。
同（おな）じ意味（いみ）の文（ぶん）を選（えら）んでください。', 'Choose the sentence with the same meaning.', '["先生（せんせい）に本（ほん）をあげました。","先生（せんせい）から本（ほん）を買（か）いました。","先生（せんせい）が私（わたし）に本（ほん）を貸（か）しました。","私（わたし）が先生（せんせい）に本（ほん）を貸（か）しました。"]', 2, '第（だい）7課（か）・言（い）い換（か）え: 借（か）りる and 貸（か）す describe opposite sides of the same action.', NULL),
('n5-s3-q24', 'n5-set-3', 'N5', 'vocabulary', TRUE, 24, '机（つくえ）の上（うえ）に何（なに）もありません。
同（おな）じ意味（いみ）の文（ぶん）を選（えら）んでください。', 'Choose the sentence with the same meaning.', '["机（つくえ）の上（うえ）に人（ひと）がいます。","机（つくえ）の上（うえ）は空（から）です。","机（つくえ）の上（うえ）に何（なに）かあります。","机（つくえ）がありません。"]', 1, '第（だい）10課（か）・言（い）い換（か）え: 何（なに）もありません means nothing is there.', NULL),
('n5-s3-q25', 'n5-set-3', 'N5', 'vocabulary', TRUE, 25, '新（あたら）しい靴（くつ）がほしいです。
同（おな）じ意味（いみ）の文（ぶん）を選（えら）んでください。', 'Choose the sentence with the same meaning.', '["新（あたら）しい靴（くつ）を買（か）いたいです。","新（あたら）しい靴（くつ）を売（う）りたいです。","新（あたら）しい靴（くつ）があります。","新（あたら）しい靴（くつ）が嫌（きら）いです。"]', 0, '第（だい）13課（か）・言（い）い換（か）え: Wanting shoes is close to wanting to buy them.', NULL),
('n5-s3-q26', 'n5-set-3', 'N5', 'grammar-reading', TRUE, 26, '＿＿は時計（とけい）です。私（わたし）の近（ちか）くにあります。', 'This near me is a watch.', '["この","ここ","どれ","これ"]', 3, '第（だい）2課（か）・文法形式（ぶんぽうけいしき）: これ refers to a thing near the speaker and stands alone.', NULL),
('n5-s3-q27', 'n5-set-3', 'N5', 'grammar-reading', TRUE, 27, '木村（きむら）は七時（しちじ）＿＿起（お）きます。', '木村（きむら） gets up at 七時（しちじ）.', '["を","へ","に","で"]', 2, '第（だい）4課（か）・文法形式（ぶんぽうけいしき）: に marks a specific time.', NULL),
('n5-s3-q28', 'n5-set-3', 'N5', 'grammar-reading', TRUE, 28, '日本語（にほんご）＿＿手紙（てがみ）を書（か）きます。', 'I write a letter in Japanese.', '["へ","で","を","に"]', 1, '第（だい）7課（か）・文法形式（ぶんぽうけいしき）: で marks the language or means used.', NULL),
('n5-s3-q29', 'n5-set-3', 'N5', 'grammar-reading', TRUE, 29, '学校（がっこう）＿＿佐藤（さとう）がいます。', '佐藤（さとう） is at the 学校（がっこう）.', '["に","を","で","へ"]', 0, '第（だい）10課（か）・文法形式（ぶんぽうけいしき）: に marks the place where a person exists.', NULL),
('n5-s3-q30', 'n5-set-3', 'N5', 'grammar-reading', TRUE, 30, 'すみません。ここで待（ま）って＿＿。', 'Please do the requested action.', '["います","あります","なります","ください"]', 3, '第（だい）14課（か）・文法形式（ぶんぽうけいしき）: The て-form plus ください makes a polite request.', NULL),
('n5-s3-q31', 'n5-set-3', 'N5', 'grammar-reading', TRUE, 31, '明日（あした）までに九時（くじ）までに来（こ）なければ＿＿。', 'The action must be completed by tomorrow.', '["いけます","ください","なりません","ありません"]', 2, '第（だい）17課（か）・文法形式（ぶんぽうけいしき）: ない-form without い + ければなりません expresses obligation.', NULL),
('n5-s3-q32', 'n5-set-3', 'N5', 'grammar-reading', TRUE, 32, 'この時計（とけい）が＿＿、買（か）います。', 'Choose the たら conditional form.', '["安（やす）いまで","安（やす）かったら","安（やす）くても","安（やす）いから"]', 1, '第（だい）25課（か）・文法形式（ぶんぽうけいしき）: The たら form expresses a condition for the following action.', NULL),
('n5-s3-q33', 'n5-set-3', 'N5', 'grammar-reading', TRUE, 33, '作（つく）り方（かた）として正（ただ）しい文（ぶん）はどれですか。', 'Choose the correctly formed sentence.', '["野菜（やさい）を切（き）って、鍋（なべ）に入（い）れて、煮（に）ます。","野菜（やさい）を切（き）りて、鍋（なべ）に入（い）れて、煮（に）ます。","野菜（やさい）を切（き）って、鍋（なべ）に入（い）れって、煮（に）ます。","野菜（やさい）を切（き）るて、鍋（なべ）に入（い）れて、煮（に）ます。"]', 0, '第（だい）16課（か）・文（ぶん）の組（く）み立（た）て: Correct て-forms connect the cooking steps.', NULL),
('n5-s3-q34', 'n5-set-3', 'N5', 'grammar-reading', TRUE, 34, '正（ただ）しい文（ぶん）を選（えら）んでください。', 'Choose the correctly formed sentence.', '["日本（にほん）へ来（き）た前（まえ）に、日本語（にほんご）を勉強（べんきょう）しました。","日本（にほん）へ来（き）て前（まえ）に、日本語（にほんご）を勉強（べんきょう）しました。","日本（にほん）へ来（き）ます前（まえ）に、日本語（にほんご）を勉強（べんきょう）しました。","日本（にほん）へ来（く）る前（まえ）に、日本語（にほんご）を勉強（べんきょう）しました。"]', 3, '第（だい）18課（か）・文（ぶん）の組（く）み立（た）て: Dictionary form 来（く）る is used before 前（まえ）に.', NULL),
('n5-s3-q35', 'n5-set-3', 'N5', 'grammar-reading', TRUE, 35, '変化（へんか）について正（ただ）しい文（ぶん）はどれですか。', 'Choose the correctly formed sentence.', '["日本語（にほんご）が上手（じょうず）になりますた。","日本語（にほんご）が上手（じょうず）をなりました。","日本語（にほんご）が上手（じょうず）になりました。","日本語（にほんご）が上手（じょうず）くなりました。"]', 2, '第（だい）19課（か）・文（ぶん）の組（く）み立（た）て: Na-adjective + になります expresses change.', NULL),
('n5-s3-q36', 'n5-set-3', 'N5', 'grammar-reading', TRUE, 36, '予想（よそう）を確認（かくにん）する文（ぶん）はどれですか。', 'Choose the correctly formed sentence.', '["明日（あした）は寒（さむ）かったでしょうです。","明日（あした）は寒（さむ）いでしょう。","明日（あした）は寒（さむ）いですでしょう。","明日（あした）は寒（さむ）くでしょう。"]', 1, '第（だい）21課（か）・文（ぶん）の組（く）み立（た）て: Plain adjective + でしょう expresses probability or seeks agreement.', NULL),
('n5-s3-q37', 'n5-set-3', 'N5', 'grammar-reading', TRUE, 37, '友達（ともだち）に聞（き）きました。『昨日（きのう）の映画（えいが）、＿＿？』', 'Choose the grammar that best completes the text.', '["おもしろかった","おもしろかったです","おもしろいでした","おもしろく"]', 0, '第（だい）20課（か）・文章文法（ぶんしょうぶんぽう）: Casual speech uses the plain past adjective form.', NULL),
('n5-s3-q38', 'n5-set-3', 'N5', 'grammar-reading', TRUE, 38, 'このボタンを押（お）す＿＿、切符（きっぷ）が出（で）ます。', 'Choose the grammar that best completes the text.', '["ときに","ので","でも","と"]', 3, '第（だい）23課（か）・文章文法（ぶんしょうぶんぽう）: Dictionary form + と expresses an automatic result.', NULL),
('n5-s3-q39', 'n5-set-3', 'N5', 'grammar-reading', TRUE, 39, '私（わたし）は妹（いもうと）に日本語（にほんご）を教（おし）えて＿＿。', 'Choose the grammar that best completes the text.', '["もらいました","なりました","あげました","くれました"]', 2, '第（だい）24課（か）・文章文法（ぶんしょうぶんぽう）: て-form + あげました describes doing a helpful action for someone else.', NULL),
('n5-s3-q40', 'n5-set-3', 'N5', 'grammar-reading', TRUE, 40, '短（みじか）い文章（ぶんしょう）を読（よ）んでください。
木村（きむら）さんは音楽（おんがく）が好（す）きです。歌（うた）は上手（じょうず）ですが、ピアノはあまり上手（じょうず）ではありません。
木村（きむら）さんは何（なに）が上手（じょうず）ですか。', 'Kimura likes music and sings well but is not very good at piano. What is Kimura good at?', '["スポーツ","歌（うた）","ピアノ","料理（りょうり）"]', 1, '第（だい）9課（か）・読解（どっかい）: The passage says Kimura sings well.', NULL),
('n5-s3-q41', 'n5-set-3', 'N5', 'grammar-reading', TRUE, 41, 'メールを読（よ）んでください。
佐藤（さとう）さんへ
日曜日（にちようび）に京都（きょうと）へ写真（しゃしん）を撮（と）りに行（い）きます。一緒（いっしょ）に行（い）きませんか。
木村（きむら）
木村（きむら）さんは京都（きょうと）で何（なに）をしたいですか。', 'Kimura invites Sato to Kyoto on Sunday to take photographs. What does Kimura want to do?', '["写真（しゃしん）を撮（と）りたいです。","日本語（にほんご）を勉強（べんきょう）したいです。","働（はたら）きたいです。","本（ほん）を買（か）いたいです。"]', 0, '第（だい）13課（か）・読解（どっかい）: The purpose marked by に is taking photographs.', NULL),
('n5-s3-q42', 'n5-set-3', 'N5', 'grammar-reading', TRUE, 42, '学校（がっこう）の予定（よてい）
月曜日（げつようび）：漢字（かんじ）の試験（しけん）
水曜日（すいようび）：図書館（としょかん）へ行（い）く
金曜日（きんようび）：休（やす）み
試験（しけん）はいつですか。', 'The school schedule has a kanji test Monday, library Wednesday, and holiday Friday. When is the test?', '["水曜日（すいようび）","金曜日（きんようび）","日曜日（にちようび）","月曜日（げつようび）"]', 3, '第（だい）4課（か）・読解（どっかい）: The schedule places the test on Monday.', NULL),
('n5-s3-q43', 'n5-set-3', 'N5', 'grammar-reading', TRUE, 43, '京都（きょうと）は東京（とうきょう）より小（ちい）さいですが、古（ふる）い寺（てら）がたくさんあります。東京（とうきょう）は京都（きょうと）より人（ひと）が多（おお）いです。
正（ただ）しい文（ぶん）はどれですか。', 'Kyoto is smaller and has many old temples; Tokyo has more people. Which is correct?', '["京都（きょうと）に寺（てら）はありません。","東京（とうきょう）は京都（きょうと）より古（ふる）いです。","東京（とうきょう）は京都（きょうと）より人（ひと）が多（おお）いです。","京都（きょうと）は東京（とうきょう）より大（おお）きいです。"]', 2, '第（だい）12課（か）・読解（どっかい）: The passage says Tokyo has more people.', NULL),
('n5-s3-q44', 'n5-set-3', 'N5', 'grammar-reading', TRUE, 44, 'これは父（ちち）が誕生日（たんじょうび）にくれた時計（とけい）です。昨日（きのう）買（か）った時計（とけい）は妹（いもうと）のです。
私（わたし）の時計（とけい）はどれですか。', 'This is the watch my father gave me; the one bought yesterday is my sister''s. Which is mine?', '["店（みせ）にある時計（とけい）","父（ちち）がくれた時計（とけい）","昨日（きのう）買（か）った時計（とけい）","妹（いもうと）がくれた時計（とけい）"]', 1, '第（だい）22課（か）・読解（どっかい）: The speaker identifies the father''s gift as their watch.', NULL),
('n5-s3-q45', 'n5-set-3', 'N5', 'grammar-reading', TRUE, 45, '教室（きょうしつ）でのお願（ねが）い
授業（じゅぎょう）が始（はじ）まる前（まえ）に電話（でんわ）を消（け）してください。質問（しつもん）がある人（ひと）は手（て）を上（あ）げてください。
授業（じゅぎょう）の前（まえ）に何（なに）をしますか。', 'The classroom notice asks students to turn off phones before class and raise a hand for questions. What should they do first?', '["電話（でんわ）を消（け）します。","電話（でんわ）を使（つか）います。","教室（きょうしつ）を出（で）ます。","本（ほん）を返（かえ）します。"]', 0, '第（だい）14課（か）・読解（どっかい）: Students are asked to turn off phones before class.', NULL),
('n5-s3-q46', 'n5-set-3', 'N5', 'listening', TRUE, 46, '男（おとこ）の人（ひと）はどこへ行（い）きますか。', 'Listen and choose what the person will do.', '["病院（びょういん）","学校（がっこう）","公園（こうえん）","本屋（ほんや）"]', 3, '第（だい）3課（か）・課題理解（かだいりかい）: He goes to the bookstore for a dictionary.', '日本語（にほんご）の辞書（じしょ）がほしいです。本屋（ほんや）へ買（か）いに行（い）きます。'),
('n5-s3-q47', 'n5-set-3', 'N5', 'listening', TRUE, 47, '女（おんな）の人（ひと）は何（なに）で京都（きょうと）へ行（い）きますか。', 'Listen and choose what the person will do.', '["バス","車（くるま）","新幹線（しんかんせん）","飛行機（ひこうき）"]', 2, '第（だい）5課（か）・課題理解（かだいりかい）: She takes the bullet train.', '飛行機（ひこうき）は高（たか）いですから、新幹線（しんかんせん）で京都（きょうと）へ行（い）きます。'),
('n5-s3-q48', 'n5-set-3', 'N5', 'listening', TRUE, 48, '女（おんな）の人（ひと）は妹（いもうと）に何（なに）をあげますか。', 'Listen and choose what the person will do.', '["かばん","時計（とけい）","花（はな）","本（ほん）"]', 1, '第（だい）7課（か）・課題理解（かだいりかい）: She gives her sister a watch.', '妹（いもうと）の誕生日（たんじょうび）です。新（あたら）しい時計（とけい）をあげます。'),
('n5-s3-q49', 'n5-set-3', 'N5', 'listening', TRUE, 49, '学生（がくせい）は紙（かみ）を何枚（なんまい）使（つか）いますか。', 'Listen and choose what the person will do.', '["五枚（ごまい）","三枚（さんまい）","四枚（よんまい）","六枚（ろくまい）"]', 0, '第（だい）11課（か）・課題理解（かだいりかい）: Five problems require five sheets.', '問題（もんだい）は五（いつ）つあります。一（ひと）つの問題（もんだい）に紙（かみ）を一枚（いちまい）使（つか）ってください。'),
('n5-s3-q50', 'n5-set-3', 'N5', 'listening', TRUE, 50, '二人（ふたり）は何（なに）をしに公園（こうえん）へ行（い）きますか。', 'Listen and choose what the person will do.', '["本（ほん）を読（よ）みます","昼（ひる）ご飯（はん）を買（か）います","日本語（にほんご）を勉強（べんきょう）します","写真（しゃしん）を撮（と）ります"]', 3, '第（だい）13課（か）・課題理解（かだいりかい）: They will take photographs of the blossoms.', '桜（さくら）がきれいですから、公園（こうえん）へ写真（しゃしん）を撮（と）りに行（い）きましょう。'),
('n5-s3-q51', 'n5-set-3', 'N5', 'listening', TRUE, 51, '店（みせ）は何時（なんじ）に閉（し）まりますか。', 'Listen and choose the key detail.', '["七時半（しちじはん）","八時（はちじ）","七時（しちじ）","六時半（ろくじはん）"]', 2, '第（だい）4課（か）・要点理解（ようてんりかい）: Sunday closing time is 7:00.', '平日（へいじつ）は八時（はちじ）までですが、今日（きょう）は日曜日（にちようび）ですから七時（しちじ）に閉（し）まります。'),
('n5-s3-q52', 'n5-set-3', 'N5', 'listening', TRUE, 52, '女（おんな）の人（ひと）は何（なに）を買（か）いますか。', 'Listen and choose the key detail.', '["卵（たまご）","魚（さかな）","肉（にく）","野菜（やさい）"]', 1, '第（だい）6課（か）・要点理解（ようてんりかい）: She needs fish.', '肉（にく）は家（いえ）にあります。今日（きょう）は魚（さかな）を買（か）います。'),
('n5-s3-q53', 'n5-set-3', 'N5', 'listening', TRUE, 53, '男（おとこ）の人（ひと）はどの靴（くつ）を選（えら）びますか。', 'Listen and choose the key detail.', '["安（やす）い靴（くつ）","大（おお）きい靴（くつ）","白（しろ）い靴（くつ）","古（ふる）い靴（くつ）"]', 0, '第（だい）8課（か）・要点理解（ようてんりかい）: He selects the inexpensive shoes.', '白（しろ）い靴（くつ）は高（たか）いですね。こちらの安（やす）い靴（くつ）にします。'),
('n5-s3-q54', 'n5-set-3', 'N5', 'listening', TRUE, 54, '女（おんな）の人（ひと）はどうして日本語（にほんご）が上手（じょうず）ですか。', 'Listen and choose the key detail.', '["先生（せんせい）ではありませんから","漢字（かんじ）が嫌（きら）いですから","毎日（まいにち）英語（えいご）を話（はな）しますから","日本（にほん）に三年（さんねん）いますから"]', 3, '第（だい）9課（か）・要点理解（ようてんりかい）: Three years in Japan explains the skill.', '日本（にほん）に来（き）て三年（さんねん）ですから、日本語（にほんご）が上手（じょうず）になりました。'),
('n5-s3-q55', 'n5-set-3', 'N5', 'listening', TRUE, 55, '昨日（きのう）の天気（てんき）はどうでしたか。', 'Listen and choose the key detail.', '["暖（あたた）かかったです","涼（すず）しかったです","寒（さむ）かったです","暑（あつ）かったです"]', 2, '第（だい）12課（か）・要点理解（ようてんりかい）: Snow made yesterday cold.', '雪（ゆき）が降（ふ）って、昨日（きのう）はとても寒（さむ）かったです。'),
('n5-s3-q56', 'n5-set-3', 'N5', 'listening', TRUE, 56, '初（はじ）めて会（あ）う人（ひと）に何（なん）と言（い）いますか。', 'What do you say when meeting someone for the first time?', '["お大事（だいじ）に。","初（はじ）めまして。","いただきます。","お帰（かえ）りなさい。"]', 1, '第（だい）1課（か）・発話表現（はつわひょうげん）: 初（はじ）めまして is used at a first meeting.', 'あなたはタイから来（き）ました。初（はじ）めて木村（きむら）に会（あ）います。何（なん）と言（い）いますか。'),
('n5-s3-q57', 'n5-set-3', 'N5', 'listening', TRUE, 57, '店（みせ）で値段（ねだん）を聞（き）きます。何（なん）と言（い）いますか。', 'What do you say to ask the price in a shop?', '["この辞書（じしょ）はいくらですか。","この辞書（じしょ）はどこですか。","この辞書（じしょ）はだれですか。","この辞書（じしょ）はいつですか。"]', 0, '第（だい）2課（か）・発話表現（はつわひょうげん）: いくら asks a price.', '店（みせ）でこの辞書（じしょ）の値段（ねだん）を知（し）りたいです。何（なん）と言（い）いますか。'),
('n5-s3-q58', 'n5-set-3', 'N5', 'listening', TRUE, 58, '丁寧（ていねい）にお願（ねが）いします。何（なん）と言（い）いますか。', 'Which expression makes the polite request?', '["名前（なまえ）を書くません。","名前（なまえ）を書くことがあります。","名前（なまえ）を書くたいです。","名前（なまえ）を書（か）いてください。"]', 3, '第（だい）14課（か）・発話表現（はつわひょうげん）: The て-form plus ください makes a polite request.', '佐藤（さとう）に名前（なまえ）を書くことをお願（ねが）いします。何（なん）と言（い）いますか。'),
('n5-s3-q59', 'n5-set-3', 'N5', 'listening', TRUE, 59, '許可（きょか）を聞（き）きます。何（なん）と言（い）いますか。', 'What do you say to ask permission?', '["窓（まど）の近（ちか）くに座（すわ）らないでください。","窓（まど）の近（ちか）くに座（すわ）らなければなりません。","窓（まど）の近（ちか）くに座（すわ）ってもいいですか。","窓（まど）の近（ちか）くに座（すわ）ってはいけません。"]', 2, '第（だい）15課（か）・発話表現（はつわひょうげん）: て-form + もいいですか asks permission.', '窓（まど）の近（ちか）くに座（すわ）りたいです。先生（せんせい）に何（なん）と言（い）いますか。'),
('n5-s3-q60', 'n5-set-3', 'N5', 'listening', TRUE, 60, '手伝（てつだ）いを申（もう）し出（で）ます。何（なん）と言（い）いますか。', 'What do you say to offer help?', '["このかばんを持（も）たないでください。","このかばんを持（も）ちましょうか。","このかばんを持（も）ってはいけません。","このかばんを持（も）ちたいですか。"]', 1, '第（だい）16課（か）・発話表現（はつわひょうげん）: Verb stem + ましょうか can offer assistance.', '木村（きむら）がこのかばんを運（はこ）んでいます。手伝（てつだ）いたいです。何（なん）と言（い）いますか。'),
('n5-s3-q61', 'n5-set-3', 'N5', 'listening', TRUE, 61, '友達（ともだち）の助（たす）けにお礼（れい）を言（い）います。何（なん）と言（い）いますか。', 'What do you say to thank a friend for helping?', '["写真（しゃしん）を撮（と）ってくれて、ありがとう。","写真（しゃしん）を撮（と）ってはいけません。","写真（しゃしん）を撮（と）ってくださいか。","写真（しゃしん）を撮（と）ってありません。"]', 0, '第（だい）24課（か）・発話表現（はつわひょうげん）: てくれてありがとう thanks someone for a helpful action.', '佐藤（さとう）が写真（しゃしん）を撮（と）ってくれました。何（なん）と言（い）いますか。'),
('n5-s3-q62', 'n5-set-3', 'N5', 'listening', TRUE, 62, 'いちばん自然（しぜん）な返事（へんじ）を選（えら）んでください。', 'Choose the most natural response.', '["はい、います。","いいえ、ありませんでしたか。","いいえ、します。","はい、あります。"]', 3, '第（だい）19課（か）・即時応答（そくじおうとう）: はい、あります answers an experience question.', '京都（きょうと）へ行（い）ったことがありますか。'),
('n5-s3-q63', 'n5-set-3', 'N5', 'listening', TRUE, 63, 'いちばん自然（しぜん）な返事（へんじ）を選（えら）んでください。', 'Choose the most natural casual response.', '["いいえ、行（い）きました。","うん、ありません。","うん、いいよ。","はい、いいですか。"]', 2, '第（だい）20課（か）・即時応答（そくじおうとう）: うん、いいよ is a natural casual acceptance.', '日曜日（にちようび）、公園（こうえん）で写真（しゃしん）を撮（と）る？'),
('n5-s3-q64', 'n5-set-3', 'N5', 'listening', TRUE, 64, 'いちばん自然（しぜん）な返事（へんじ）を選（えら）んでください。', 'Choose the most natural response to an opinion question.', '["はい、思（おも）いでした。","はい、私（わたし）もそう思（おも）います。","はい、そう言（い）いましたか。","いいえ、思（おも）ってください。"]', 1, '第（だい）21課（か）・即時応答（そくじおうとう）: そう思（おも）います naturally agrees with the prediction.', '試験（しけん）は難（むずか）しいと思（おも）いますか。'),
('n5-s3-q65', 'n5-set-3', 'N5', 'listening', TRUE, 65, 'いちばん自然（しぜん）な返事（へんじ）を選（えら）んでください。', 'Choose the response that identifies the modified noun.', '["日本（にほん）で作（つく）ったカメラです。","はい、買（か）います。","いいえ、ありません。","三時（さんじ）です。"]', 0, '第（だい）22課（か）・即時応答（そくじおうとう）: The answer identifies the item with a noun-modifying clause.', 'どれがあなたのものですか。'),
('n5-s3-q66', 'n5-set-3', 'N5', 'listening', TRUE, 66, 'いちばん自然（しぜん）な返事（へんじ）を選（えら）んでください。', 'Choose the response describing the result.', '["昨日（きのう）しました。","三人（さんにん）です。","七時（しちじ）からです。","外（そと）へ出（で）ます。"]', 3, '第（だい）23課（か）・即時応答（そくじおうとう）: The response states what happens as a result.', 'このドアを開（あ）けると、どうなりますか。')
ON DUPLICATE KEY UPDATE
  set_id = VALUES(set_id),
  level = VALUES(level),
  section = VALUES(section),
  active = VALUES(active),
  order_no = VALUES(order_no),
  prompt = VALUES(prompt),
  prompt_en = VALUES(prompt_en),
  options = VALUES(options),
  answer_index = VALUES(answer_index),
  explanation = VALUES(explanation),
  audio_text = VALUES(audio_text),
  updated_at = CURRENT_TIMESTAMP(3);

INSERT INTO questions
  (id, set_id, level, section, active, order_no, prompt, prompt_en, options, answer_index, explanation, audio_text)
VALUES
('n5-s3-q67', 'n5-set-3', 'N5', 'listening', TRUE, 67, 'いちばん自然（しぜん）な返事（へんじ）を選（えら）んでください。', 'Choose the response naming the helper.', '["友達（ともだち）に手伝（てつだ）います。","友達（ともだち）で手伝（てつだ）いません。","友達（ともだち）が手伝（てつだ）ってくれました。","友達（ともだち）を手伝（てつだ）いましたか。"]', 2, '第（だい）24課（か）・即時応答（そくじおうとう）: The が-marked person is the giver of the helpful action.', 'だれが手伝（てつだ）ってくれましたか。'),
('n5-s4-q1', 'n5-set-4', 'N5', 'vocabulary', TRUE, 1, 'あの人（ひと）は日本語（にほんご）の＿＿です。', 'That person is a Japanese-language teacher.', '["先生（せんせい）","学生（がくせい）","会社員（かいしゃいん）","医者（いしゃ）"]', 0, '第（だい）1課（か）・文脈語彙（ぶんみゃくごい）: 先生（せんせい）は teacher です。', NULL),
('n5-s4-q2', 'n5-set-4', 'N5', 'vocabulary', TRUE, 2, 'これは雨（あめ）の日（ひ）に使（つか）う＿＿です。', 'This is something used on rainy days.', '["傘（かさ）","机（つくえ）","椅子（いす）","辞書（じしょ）"]', 0, '第（だい）2課（か）・文脈語彙（ぶんみゃくごい）: 傘（かさ）は雨（あめ）の日（ひ）に使（つか）います。', NULL),
('n5-s4-q3', 'n5-set-4', 'N5', 'grammar-reading', TRUE, 3, '私（わたし）＿＿会社員（かいしゃいん）です。', 'I am an office worker.', '["は","を","に","で"]', 0, '第（だい）1課（か）・文法形式（ぶんぽうけいしき）: は marks the topic 私（わたし）.', NULL),
('n5-s4-q4', 'n5-set-4', 'N5', 'grammar-reading', TRUE, 4, '日曜日（にちようび）に家族（かぞく）＿＿公園（こうえん）へ行（い）きます。', 'On Sunday, I go to the park with my family.', '["と","を","へ","の"]', 0, '第（だい）5課（か）・文法形式（ぶんぽうけいしき）: と marks the person who accompanies the speaker.', NULL),
('n5-s4-q5', 'n5-set-4', 'N5', 'listening', TRUE, 5, '女（おんな）の人（ひと）はどこへ行（い）きますか。', 'Where will the woman go?', '["駅（えき）","銀行（ぎんこう）","病院（びょういん）","学校（がっこう）"]', 1, '第（だい）5課（か）・課題理解（かだいりかい）: 銀行（ぎんこう）へ行（い）きます。', 'お金（かね）がありませんから、今（いま）から銀行（ぎんこう）へ行（い）きます。'),
('n5-s4-q6', 'n5-set-4', 'N5', 'listening', TRUE, 6, '男（おとこ）の人（ひと）は何（なに）を食（た）べますか。', 'What will the man eat?', '["パン","すし","カレー","そば"]', 2, '第（だい）6課（か）・要点理解（ようてんりかい）: 男（おとこ）の人（ひと）はカレーを選（えら）びます。', 'パンは朝（あさ）食（た）べました。昼（ひる）はカレーを食（た）べます。'),
('n5-s4-q7', 'n5-set-4', 'N5', 'vocabulary', TRUE, 7, '紙（かみ）に名前を書（か）いてください。
「名前」の読（よ）み方（かた）を選（えら）んでください。', 'Choose the reading of 名前.', '["なまえ","なめい","めいまえ","なまい"]', 0, '第（だい）1課（か）・漢字読（かんじよ）み: 「名前」は「なまえ」と読（よ）みます。', NULL),
('n5-s4-q8', 'n5-set-4', 'N5', 'vocabulary', TRUE, 8, 'お国はどちらですか。
「国」の読（よ）み方（かた）を選（えら）んでください。', 'Choose the reading of 国.', '["こく","ぐに","くん","くに"]', 3, '第（だい）1課（か）・漢字読（かんじよ）み: 「国」は「くに」と読（よ）みます。', NULL),
('n5-s4-q9', 'n5-set-4', 'N5', 'vocabulary', TRUE, 9, 'これは日本（にほん）の本です。
「本」の読（よ）み方（かた）を選（えら）んでください。', 'Choose the reading of 本.', '["ぼん","ぽん","ほん","もと"]', 2, '第（だい）2課（か）・漢字読（かんじよ）み: 「本」は「ほん」と読（よ）みます。', NULL),
('n5-s4-q10', 'n5-set-4', 'N5', 'vocabulary', TRUE, 10, 'その時計はだれのですか。
「時計」の読（よ）み方（かた）を選（えら）んでください。', 'Choose the reading of 時計.', '["とけ","とけい","じけい","ときけい"]', 1, '第（だい）2課（か）・漢字読（かんじよ）み: 「時計」は「とけい」と読（よ）みます。', NULL),
('n5-s4-q11', 'n5-set-4', 'N5', 'vocabulary', TRUE, 11, '銀行は駅（えき）の前（まえ）です。
「銀行」の読（よ）み方（かた）を選（えら）んでください。', 'Choose the reading of 銀行.', '["ぎんこう","きんこう","ぎんごう","ぎんこ"]', 0, '第（だい）3課（か）・漢字読（かんじよ）み: 「銀行」は「ぎんこう」と読（よ）みます。', NULL),
('n5-s4-q12', 'n5-set-4', 'N5', 'vocabulary', TRUE, 12, 'レストランは地下です。
「地下」の読（よ）み方（かた）を選（えら）んでください。', 'Choose the reading of 地下.', '["じか","ちした","じした","ちか"]', 3, '第（だい）3課（か）・漢字読（かんじよ）み: 「地下」は「ちか」と読（よ）みます。', NULL),
('n5-s4-q13', 'n5-set-4', 'N5', 'vocabulary', TRUE, 13, '今日は何曜日（なんようび）ですか。
「今日」の読（よ）み方（かた）を選（えら）んでください。', 'Choose the reading of 今日.', '["きょにち","いまひ","きょう","こんひ"]', 2, '第（だい）4課（か）・漢字読（かんじよ）み: 「今日」は「きょう」と読（よ）みます。', NULL),
('n5-s4-q14', 'n5-set-4', 'N5', 'vocabulary', TRUE, 14, '『わたし』は学生（がくせい）です。
『わたし』の漢字（かんじ）を選（えら）んでください。', 'Choose the kanji for わたし.', '["友","私","父","母"]', 1, '第（だい）1課（か）・表記（ひょうき）: 『わたし』は「私」と書（か）きます。', NULL),
('n5-s4-q15', 'n5-set-4', 'N5', 'vocabulary', TRUE, 15, '『て』で食（た）べます。
『て』の漢字（かんじ）を選（えら）んでください。', 'Choose the kanji for て.', '["手","足","目","耳"]', 0, '第（だい）7課（か）・表記（ひょうき）: 『て』は「手」と書（か）きます。', NULL),
('n5-s4-q16', 'n5-set-4', 'N5', 'vocabulary', TRUE, 16, '駅（えき）の『みぎ』に店（みせ）があります。
『みぎ』の漢字（かんじ）を選（えら）んでください。', 'Choose the kanji for みぎ.', '["左","石","外","右"]', 3, '第（だい）10課（か）・表記（ひょうき）: 『みぎ』は「右」と書（か）きます。', NULL),
('n5-s4-q17', 'n5-set-4', 'N5', 'vocabulary', TRUE, 17, 'りんごを『みっつ』買（か）います。
『みっつ』の漢字（かんじ）を選（えら）んでください。', 'Choose the kanji for みっつ.', '["四つ","五つ","三つ","二つ"]', 2, '第（だい）11課（か）・表記（ひょうき）: 『みっつ』は「三つ」と書（か）きます。', NULL),
('n5-s4-q18', 'n5-set-4', 'N5', 'vocabulary', TRUE, 18, '『らいげつ』国（くに）へ帰（かえ）ります。
『らいげつ』の漢字（かんじ）を選（えら）んでください。', 'Choose the kanji for らいげつ.', '["先月","来月","今月","毎月"]', 1, '第（だい）5課（か）・表記（ひょうき）: 『らいげつ』は「来月」と書（か）きます。', NULL),
('n5-s4-q19', 'n5-set-4', 'N5', 'vocabulary', TRUE, 19, '毎晩（まいばん）、十一時（じゅういちじ）に＿＿。', 'Choose the word that best completes the sentence.', '["寝（ね）ます","起（お）きます","働（はたら）きます","終（お）わります"]', 0, '第（だい）4課（か）・文脈語彙（ぶんみゃくごい）: 寝（ね）ます means go to sleep.', NULL),
('n5-s4-q20', 'n5-set-4', 'N5', 'vocabulary', TRUE, 20, '店（みせ）で写真（しゃしん）を＿＿。', 'Choose the word that best completes the sentence.', '["切（き）ります","消（け）します","閉（し）めます","撮（と）ります"]', 3, '第（だい）6課（か）・文脈語彙（ぶんみゃくごい）: 写真（しゃしん） is taken with 撮（と）ります.', NULL),
('n5-s4-q21', 'n5-set-4', 'N5', 'vocabulary', TRUE, 21, '漢字（かんじ）が＿＿。教（おし）えてください。', 'Choose the word that best completes the sentence.', '["いません","できます","分（わ）かりません","ありません"]', 2, '第（だい）9課（か）・文脈語彙（ぶんみゃくごい）: 分（わ）かりません means do not understand.', NULL),
('n5-s4-q22', 'n5-set-4', 'N5', 'vocabulary', TRUE, 22, '休（やす）みの日（ひ）は映画（えいが）を見（み）に＿＿。', 'Choose the word that best completes the sentence.', '["います","行（い）きます","来（き）ます","帰（かえ）ります"]', 1, '第（だい）13課（か）・文脈語彙（ぶんみゃくごい）: Verb stem + に行（い）きます expresses purpose.', NULL),
('n5-s4-q23', 'n5-set-4', 'N5', 'vocabulary', TRUE, 23, 'この問題（もんだい）は簡単（かんたん）です。
同（おな）じ意味（いみ）の文（ぶん）を選（えら）んでください。', 'Choose the sentence with the same meaning.', '["この問題（もんだい）は難（むずか）しくありません。","この問題（もんだい）は長（なが）いです。","この問題（もんだい）は分（わ）かりません。","この問題（もんだい）は多（おお）いです。"]', 0, '第（だい）8課（か）・言（い）い換（か）え: 簡単（かんたん） means not difficult.', NULL),
('n5-s4-q24', 'n5-set-4', 'N5', 'vocabulary', TRUE, 24, '兄（あに）は料理（りょうり）が上手（じょうず）です。
同（おな）じ意味（いみ）の文（ぶん）を選（えら）んでください。', 'Choose the sentence with the same meaning.', '["兄（あに）は料理（りょうり）が嫌（きら）いです。","兄（あに）は料理（りょうり）を食（た）べません。","兄（あに）は料理（りょうり）が分（わ）かりません。","兄（あに）は料理（りょうり）が得意（とくい）です。"]', 3, '第（だい）9課（か）・言（い）い換（か）え: 上手（じょうず） and 得意（とくい） both indicate skill.', NULL),
('n5-s4-q25', 'n5-set-4', 'N5', 'vocabulary', TRUE, 25, '電車（でんしゃ）はバスより速（はや）いです。
同（おな）じ意味（いみ）の文（ぶん）を選（えら）んでください。', 'Choose the sentence with the same meaning.', '["電車（でんしゃ）とバスは同（おな）じ速（はや）さです。","電車（でんしゃ）は速（はや）くありません。","バスは電車（でんしゃ）ほど速（はや）くありません。","バスは電車（でんしゃ）より速（はや）いです。"]', 2, '第（だい）12課（か）・言（い）い換（か）え: The comparison is restated with ほど...ない.', NULL),
('n5-s4-q26', 'n5-set-4', 'N5', 'grammar-reading', TRUE, 26, '＿＿は新聞（しんぶん）です。私（わたし）の近（ちか）くにあります。', 'This near me is a newspaper.', '["どれ","これ","この","ここ"]', 1, '第（だい）2課（か）・文法形式（ぶんぽうけいしき）: これ refers to a thing near the speaker and stands alone.', NULL),
('n5-s4-q27', 'n5-set-4', 'N5', 'grammar-reading', TRUE, 27, '佐藤（さとう）は十時（じゅうじ）＿＿起（お）きます。', '佐藤（さとう） gets up at 十時（じゅうじ）.', '["に","で","を","へ"]', 0, '第（だい）4課（か）・文法形式（ぶんぽうけいしき）: に marks a specific time.', NULL),
('n5-s4-q28', 'n5-set-4', 'N5', 'grammar-reading', TRUE, 28, '日本語（にほんご）＿＿手紙（てがみ）を書（か）きます。', 'I write a letter in Japanese.', '["を","に","へ","で"]', 3, '第（だい）7課（か）・文法形式（ぶんぽうけいしき）: で marks the language or means used.', NULL),
('n5-s4-q29', 'n5-set-4', 'N5', 'grammar-reading', TRUE, 29, '病院（びょういん）＿＿鈴木（すずき）がいます。', '鈴木（すずき） is at the 病院（びょういん）.', '["で","へ","に","を"]', 2, '第（だい）10課（か）・文法形式（ぶんぽうけいしき）: に marks the place where a person exists.', NULL),
('n5-s4-q30', 'n5-set-4', 'N5', 'grammar-reading', TRUE, 30, 'すみません。本（ほん）を見（み）せて＿＿。', 'Please do the requested action.', '["なります","ください","います","あります"]', 1, '第（だい）14課（か）・文法形式（ぶんぽうけいしき）: The て-form plus ください makes a polite request.', NULL),
('n5-s4-q31', 'n5-set-4', 'N5', 'grammar-reading', TRUE, 31, '明日（あした）までに毎日（まいにち）勉強（べんきょう）しなければ＿＿。', 'The action must be completed by tomorrow.', '["なりません","ありません","いけます","ください"]', 0, '第（だい）17課（か）・文法形式（ぶんぽうけいしき）: ない-form without い + ければなりません expresses obligation.', NULL),
('n5-s4-q32', 'n5-set-4', 'N5', 'grammar-reading', TRUE, 32, '＿＿、公園（こうえん）へ行（い）きます。', 'Choose the たら conditional form.', '["日曜日（にちようび）でも","日曜日（にちようび）から","日曜日（にちようび）まで","日曜日（にちようび）だったら"]', 3, '第（だい）25課（か）・文法形式（ぶんぽうけいしき）: The たら form expresses a condition for the following action.', NULL),
('n5-s4-q33', 'n5-set-4', 'N5', 'grammar-reading', TRUE, 33, '道順（みちじゅん）として正（ただ）しい文（ぶん）はどれですか。', 'Choose the correctly formed sentence.', '["橋（はし）を渡（わた）って、右（みぎ）へ曲（ま）げて、駅（えき）まで行（い）きます。","橋（はし）を渡（わた）るて、右（みぎ）へ曲（ま）がって、駅（えき）まで行（い）きます。","橋（はし）を渡（わた）って、右（みぎ）へ曲（ま）がって、駅（えき）まで行（い）きます。","橋（はし）を渡（わた）りて、右（みぎ）へ曲（ま）がって、駅（えき）まで行（い）きます。"]', 2, '第（だい）16課（か）・文（ぶん）の組（く）み立（た）て: The て-form connects sequential directions.', NULL),
('n5-s4-q34', 'n5-set-4', 'N5', 'grammar-reading', TRUE, 34, '正（ただ）しい文（ぶん）を選（えら）んでください。', 'Choose the correctly formed sentence.', '["旅行（りょこう）が前（まえ）に、切符（きっぷ）を買（か）います。","旅行（りょこう）の前（まえ）に、切符（きっぷ）を買（か）います。","旅行（りょこう）で前（まえ）に、切符（きっぷ）を買（か）います。","旅行（りょこう）を前（まえ）に、切符（きっぷ）を買（か）います。"]', 1, '第（だい）18課（か）・文（ぶん）の組（く）み立（た）て: Noun + の + 前（まえ）に is the correct pattern.', NULL),
('n5-s4-q35', 'n5-set-4', 'N5', 'grammar-reading', TRUE, 35, '休日（きゅうじつ）の過（す）ごし方（かた）として正（ただ）しい文（ぶん）はどれですか。', 'Choose the correctly formed sentence.', '["掃除（そうじ）したり、買（か）い物（もの）したりします。","掃除（そうじ）してり、買（か）い物（もの）してりします。","掃除（そうじ）するたり、買（か）い物（もの）するたりします。","掃除（そうじ）したり、買（か）い物（もの）しますたり。"]', 0, '第（だい）19課（か）・文（ぶん）の組（く）み立（た）て: Past form + り lists examples of activities.', NULL),
('n5-s4-q36', 'n5-set-4', 'N5', 'grammar-reading', TRUE, 36, '意見（いけん）として正（ただ）しい文（ぶん）はどれですか。', 'Choose the correctly formed sentence.', '["この町（まち）は便利（べんり）ですと思（おも）います。","この町（まち）は便利（べんり）にと思（おも）います。","この町（まち）は便利（べんり）を思（おも）います。","この町（まち）は便利（べんり）だと思（おも）います。"]', 3, '第（だい）21課（か）・文（ぶん）の組（く）み立（た）て: The plain copula だ precedes と思（おも）います after a na-adjective.', NULL),
('n5-s4-q37', 'n5-set-4', 'N5', 'grammar-reading', TRUE, 37, '母（はは）が子供（こども）に言（い）いました。『今日（きょう）は学校（がっこう）へ＿＿？』', 'Choose the grammar that best completes the text.', '["行（い）って","行（い）ったです","行（い）く","行（い）きます"]', 2, '第（だい）20課（か）・文章文法（ぶんしょうぶんぽう）: A casual non-past question uses the dictionary form.', NULL),
('n5-s4-q38', 'n5-set-4', 'N5', 'grammar-reading', TRUE, 38, '暇（ひま）な＿＿、よく図書館（としょかん）へ行（い）きます。', 'Choose the grammar that best completes the text.', '["あと","とき","から","まで"]', 1, '第（だい）23課（か）・文章文法（ぶんしょうぶんぽう）: Na-adjective + な + とき is the correct connection.', NULL),
('n5-s4-q39', 'n5-set-4', 'N5', 'grammar-reading', TRUE, 39, '誕生日（たんじょうび）に友達（ともだち）が花（はな）を買（か）って＿＿。', 'Choose the grammar that best completes the text.', '["くれました","あげました","もらいましたか","しました"]', 0, '第（だい）24課（か）・文章文法（ぶんしょうぶんぽう）: The friend did something for the speaker, so くれました is used.', NULL),
('n5-s4-q40', 'n5-set-4', 'N5', 'grammar-reading', TRUE, 40, '短（みじか）い文章（ぶんしょう）を読（よ）んでください。
佐藤（さとう）さんの家族（かぞく）は五人（ごにん）です。両親（りょうしん）と兄（あに）と妹（いもうと）がいます。兄（あに）は大学生（だいがくせい）です。
佐藤（さとう）さんには兄弟（きょうだい）が何人（なんにん）いますか。', 'Sato''s family has five people: parents, an older brother, and a younger sister. How many siblings does Sato have?', '["一人（ひとり）","三人（さんにん）","五人（ごにん）","二人（ふたり）"]', 3, '第（だい）11課（か）・読解（どっかい）: There is one older brother and one younger sister.', NULL),
('n5-s4-q41', 'n5-set-4', 'N5', 'grammar-reading', TRUE, 41, 'メールを読（よ）んでください。
鈴木（すずき）さんへ
木曜日（もくようび）に病院（びょういん）へ行（い）きますから、会社（かいしゃ）を休（やす）みます。金曜日（きんようび）は会社（かいしゃ）へ行（い）きます。
佐藤（さとう）
佐藤（さとう）さんはいつ会社（かいしゃ）を休（やす）みますか。', 'Sato will go to the hospital Thursday and take that day off, then work Friday. When is Sato off?', '["月曜日（げつようび）","土曜日（どようび）","木曜日（もくようび）","金曜日（きんようび）"]', 2, '第（だい）5課（か）・読解（どっかい）: Sato says Thursday is the day off.', NULL),
('n5-s4-q42', 'n5-set-4', 'N5', 'grammar-reading', TRUE, 42, '店（みせ）のお知（し）らせ
月曜日（げつようび）：休（やす）み
火曜日（かようび）から金曜日（きんようび）：十時（じゅうじ）から八時（はちじ）
土曜日（どようび）と日曜日（にちようび）：九時（くじ）から六時（ろくじ）
店（みせ）が開（あ）いているのはいつですか。', 'The shop is closed Monday, open Tue–Fri 10–8 and weekends 9–6. When is it open?', '["土曜日（どようび）の午後七時（ごごしちじ）","日曜日（にちようび）の午前十時（ごぜんじゅうじ）","月曜日（げつようび）の午後二時（ごごにじ）","金曜日（きんようび）の午後九時（ごごくじ）"]', 1, '第（だい）11課（か）・読解（どっかい）: Sunday at 10:00 is inside weekend opening hours.', NULL),
('n5-s4-q43', 'n5-set-4', 'N5', 'grammar-reading', TRUE, 43, 'このかばんは軽（かる）くて安（やす）いです。あのかばんは丈夫（じょうぶ）ですが、重（おも）くて高（たか）いです。
軽（かる）いかばんはどれですか。', 'This bag is light and inexpensive; that bag is durable, heavy, and expensive. Which is light?', '["このかばん","あのかばん","どちらも","どちらでもありません"]', 0, '第（だい）12課（か）・読解（どっかい）: The first bag is explicitly described as light.', NULL),
('n5-s4-q44', 'n5-set-4', 'N5', 'grammar-reading', TRUE, 44, '駅（えき）の前（まえ）で新聞（しんぶん）を読（よ）んでいる人（ひと）は私（わたし）の父（ちち）です。ベンチで寝（ね）ている人（ひと）は知（し）りません。
父（ちち）は何（なに）をしていますか。', 'The person reading a newspaper is my father; I do not know the sleeping person. What is my father doing?', '["ベンチで寝（ね）ています。","電車（でんしゃ）に乗（の）っています。","友達（ともだち）と話（はな）しています。","新聞（しんぶん）を読（よ）んでいます。"]', 3, '第（だい）22課（か）・読解（どっかい）: The relative clause says the father is reading a newspaper.', NULL),
('n5-s4-q45', 'n5-set-4', 'N5', 'grammar-reading', TRUE, 45, '図書館（としょかん）のきまり
本（ほん）は二週間（にしゅうかん）借（か）りてもいいです。食（た）べ物（もの）を持（も）って入（はい）ってはいけません。
正（ただ）しい文（ぶん）はどれですか。', 'Library rules allow books for two weeks and prohibit food. Which is correct?', '["本（ほん）は一日（いちにち）だけ借（か）ります。","図書館（としょかん）に本（ほん）はありません。","本（ほん）は二週間（にしゅうかん）借（か）りられます。","図書館（としょかん）で食（た）べてもいいです。"]', 2, '第（だい）15課（か）・読解（どっかい）: The rule allows borrowing for two weeks.', NULL),
('n5-s4-q46', 'n5-set-4', 'N5', 'listening', TRUE, 46, '女（おんな）の人（ひと）はどこへ行（い）きますか。', 'Listen and choose what the person will do.', '["駅（えき）","銀行（ぎんこう）","郵便局（ゆうびんきょく）","図書館（としょかん）"]', 1, '第（だい）3課（か）・課題理解（かだいりかい）: She goes to the bank to withdraw money.', '旅行（りょこう）のお金（かね）がいります。銀行（ぎんこう）へお金（かね）を下（お）ろしに行（い）きます。'),
('n5-s4-q47', 'n5-set-4', 'N5', 'listening', TRUE, 47, '男（おとこ）の人（ひと）は何（なに）で病院（びょういん）へ行（い）きますか。', 'Listen and choose what the person will do.', '["タクシー","自転車（じてんしゃ）","歩（ある）いて","電車（でんしゃ）"]', 0, '第（だい）5課（か）・課題理解（かだいりかい）: He takes a taxi because his leg hurts.', '足（あし）が痛（いた）いですから、歩（ある）きません。タクシーで病院（びょういん）へ行（い）きます。'),
('n5-s4-q48', 'n5-set-4', 'N5', 'listening', TRUE, 48, '学生（がくせい）は先生（せんせい）から何（なに）を借（か）りますか。', 'Listen and choose what the person will do.', '["鉛筆（えんぴつ）","本（ほん）","傘（かさ）","辞書（じしょ）"]', 3, '第（だい）7課（か）・課題理解（かだいりかい）: The student borrows a dictionary.', 'この漢字（かんじ）が分（わ）かりません。先生（せんせい）、辞書（じしょ）を貸（か）してください。'),
('n5-s4-q49', 'n5-set-4', 'N5', 'listening', TRUE, 49, '女（おんな）の人（ひと）はジュースを何本（なんぼん）買（か）いますか。', 'Listen and choose what the person will do.', '["三本（さんぼん）","四本（よんほん）","二本（にほん）","一本（いっぽん）"]', 2, '第（だい）11課（か）・課題理解（かだいりかい）: One each for two people makes two bottles.', '私（わたし）と妹（いもうと）のジュースを一本（いっぽん）ずつ買（か）います。')
ON DUPLICATE KEY UPDATE
  set_id = VALUES(set_id),
  level = VALUES(level),
  section = VALUES(section),
  active = VALUES(active),
  order_no = VALUES(order_no),
  prompt = VALUES(prompt),
  prompt_en = VALUES(prompt_en),
  options = VALUES(options),
  answer_index = VALUES(answer_index),
  explanation = VALUES(explanation),
  audio_text = VALUES(audio_text),
  updated_at = CURRENT_TIMESTAMP(3);

INSERT INTO questions
  (id, set_id, level, section, active, order_no, prompt, prompt_en, options, answer_index, explanation, audio_text)
VALUES
('n5-s4-q50', 'n5-set-4', 'N5', 'listening', TRUE, 50, '男（おとこ）の人（ひと）は何（なに）をしに駅（えき）へ行（い）きますか。', 'Listen and choose what the person will do.', '["新聞（しんぶん）を読（よ）みます","友達（ともだち）を迎（むか）えます","切符（きっぷ）を返（かえ）します","昼（ひる）ご飯（はん）を食（た）べます"]', 1, '第（だい）13課（か）・課題理解（かだいりかい）: He goes to meet a friend at the station.', '大阪（おおさか）から友達（ともだち）が来（き）ます。駅（えき）へ迎（むか）えに行（い）きます。'),
('n5-s4-q51', 'n5-set-4', 'N5', 'listening', TRUE, 51, '病院（びょういん）の予約（よやく）は何時（なんじ）ですか。', 'Listen and choose the key detail.', '["二時半（にじはん）","二時（にじ）","三時（さんじ）","三時半（さんじはん）"]', 0, '第（だい）4課（か）・要点理解（ようてんりかい）: The available appointment is 2:30.', '二時（にじ）は空（あ）いていません。二時半（にじはん）なら大丈夫（だいじょうぶ）です。'),
('n5-s4-q52', 'n5-set-4', 'N5', 'listening', TRUE, 52, '男（おとこ）の人（ひと）は朝（あさ）ご飯（はん）に何（なに）を食（た）べますか。', 'Listen and choose the key detail.', '["パン","うどん","果物（くだもの）","ご飯（はん）"]', 3, '第（だい）6課（か）・要点理解（ようてんりかい）: He will eat rice and an egg.', 'パンがありませんから、今日（きょう）はご飯（はん）と卵（たまご）を食（た）べます。'),
('n5-s4-q53', 'n5-set-4', 'N5', 'listening', TRUE, 53, '女（おんな）の人（ひと）はどの机（つくえ）を買（か）いますか。', 'Listen and choose the key detail.', '["古（ふる）い机（つくえ）","重（おも）い机（つくえ）","小（ちい）さい机（つくえ）","高（たか）い机（つくえ）"]', 2, '第（だい）8課（か）・要点理解（ようてんりかい）: She needs a small desk for a narrow room.', '部屋（へや）が狭（せま）いですから、この小（ちい）さい机（つくえ）をください。'),
('n5-s4-q54', 'n5-set-4', 'N5', 'listening', TRUE, 54, '男（おとこ）の人（ひと）はどうして早（はや）く帰（かえ）りますか。', 'Listen and choose the key detail.', '["病院（びょういん）へ行（い）きましたから","家族（かぞく）の誕生日（たんじょうび）ですから","仕事（しごと）が多（おお）いですから","電車（でんしゃ）がありませんから"]', 1, '第（だい）9課（か）・要点理解（ようてんりかい）: It is his daughter''s birthday.', '今日（きょう）は娘（むすめ）の誕生日（たんじょうび）ですから、早（はや）く帰（かえ）ります。'),
('n5-s4-q55', 'n5-set-4', 'N5', 'listening', TRUE, 55, '先週（せんしゅう）の公園（こうえん）はどうでしたか。', 'Listen and choose the key detail.', '["静（しず）かでした","にぎやかでした","暑（あつ）かったです","新（あたら）しかったです"]', 0, '第（だい）12課（か）・要点理解（ようてんりかい）: Rain made the park quiet.', '雨（あめ）の日（ひ）でしたから、人（ひと）が少（すく）なくて静（しず）かでした。'),
('n5-s4-q56', 'n5-set-4', 'N5', 'listening', TRUE, 56, '初（はじ）めて会（あ）う人（ひと）に何（なん）と言（い）いますか。', 'What do you say when meeting someone for the first time?', '["いただきます。","お帰（かえ）りなさい。","お大事（だいじ）に。","初（はじ）めまして。"]', 3, '第（だい）1課（か）・発話表現（はつわひょうげん）: 初（はじ）めまして is used at a first meeting.', 'あなたはベトナムから来（き）ました。初（はじ）めて佐藤（さとう）に会（あ）います。何（なん）と言（い）いますか。'),
('n5-s4-q57', 'n5-set-4', 'N5', 'listening', TRUE, 57, '店（みせ）で値段（ねだん）を聞（き）きます。何（なん）と言（い）いますか。', 'What do you say to ask the price in a shop?', '["その自転車（じてんしゃ）はだれですか。","その自転車（じてんしゃ）はいつですか。","その自転車（じてんしゃ）はいくらですか。","その自転車（じてんしゃ）はどこですか。"]', 2, '第（だい）2課（か）・発話表現（はつわひょうげん）: いくら asks a price.', '店（みせ）でその自転車（じてんしゃ）の値段（ねだん）を知（し）りたいです。何（なん）と言（い）いますか。'),
('n5-s4-q58', 'n5-set-4', 'N5', 'listening', TRUE, 58, '丁寧（ていねい）にお願（ねが）いします。何（なん）と言（い）いますか。', 'Which expression makes the polite request?', '["少（すこ）し待（ま）つたいです。","少（すこ）し待（ま）ってください。","少（すこ）し待（ま）つません。","少（すこ）し待（ま）つことがあります。"]', 1, '第（だい）14課（か）・発話表現（はつわひょうげん）: The て-form plus ください makes a polite request.', '鈴木（すずき）に少（すこ）し待（ま）つことをお願（ねが）いします。何（なん）と言（い）いますか。'),
('n5-s4-q59', 'n5-set-4', 'N5', 'listening', TRUE, 59, '許可（きょか）を聞（き）きます。何（なん）と言（い）いますか。', 'What do you say to ask permission?', '["先生（せんせい）の前（まえ）に座（すわ）ってもいいですか。","先生（せんせい）の前（まえ）に座（すわ）ってはいけません。","先生（せんせい）の前（まえ）に座（すわ）らないでください。","先生（せんせい）の前（まえ）に座（すわ）らなければなりません。"]', 0, '第（だい）15課（か）・発話表現（はつわひょうげん）: て-form + もいいですか asks permission.', '先生（せんせい）の前（まえ）に座（すわ）りたいです。先生（せんせい）に何（なん）と言（い）いますか。'),
('n5-s4-q60', 'n5-set-4', 'N5', 'listening', TRUE, 60, '手伝（てつだ）いを申（もう）し出（で）ます。何（なん）と言（い）いますか。', 'What do you say to offer help?', '["この机（つくえ）を持（も）ってはいけません。","この机（つくえ）を持（も）ちたいですか。","この机（つくえ）を持（も）たないでください。","この机（つくえ）を持（も）ちましょうか。"]', 3, '第（だい）16課（か）・発話表現（はつわひょうげん）: Verb stem + ましょうか can offer assistance.', '佐藤（さとう）がこの机（つくえ）を運（はこ）んでいます。手伝（てつだ）いたいです。何（なん）と言（い）いますか。'),
('n5-s4-q61', 'n5-set-4', 'N5', 'listening', TRUE, 61, '友達（ともだち）の助（たす）けにお礼（れい）を言（い）います。何（なん）と言（い）いますか。', 'What do you say to thank a friend for helping?', '["駅（えき）まで送（おく）ってくださいか。","駅（えき）まで送（おく）ってありません。","駅（えき）まで送（おく）ってくれて、ありがとう。","駅（えき）まで送（おく）ってはいけません。"]', 2, '第（だい）24課（か）・発話表現（はつわひょうげん）: てくれてありがとう thanks someone for a helpful action.', '鈴木（すずき）が駅（えき）まで送（おく）ってくれました。何（なん）と言（い）いますか。'),
('n5-s4-q62', 'n5-set-4', 'N5', 'listening', TRUE, 62, 'いちばん自然（しぜん）な返事（へんじ）を選（えら）んでください。', 'Choose the most natural response.', '["いいえ、します。","はい、あります。","はい、います。","いいえ、ありませんでしたか。"]', 1, '第（だい）19課（か）・即時応答（そくじおうとう）: はい、あります answers an experience question.', 'すしを作（つく）ったことがありますか。'),
('n5-s4-q63', 'n5-set-4', 'N5', 'listening', TRUE, 63, 'いちばん自然（しぜん）な返事（へんじ）を選（えら）んでください。', 'Choose the most natural casual response.', '["うん、いいよ。","はい、いいですか。","いいえ、行（い）きました。","うん、ありません。"]', 0, '第（だい）20課（か）・即時応答（そくじおうとう）: うん、いいよ is a natural casual acceptance.', '土曜日（どようび）、買（か）い物（もの）に行（い）く？'),
('n5-s4-q64', 'n5-set-4', 'N5', 'listening', TRUE, 64, 'いちばん自然（しぜん）な返事（へんじ）を選（えら）んでください。', 'Choose the most natural response to an opinion question.', '["はい、そう言（い）いましたか。","いいえ、思（おも）ってください。","はい、思（おも）いでした。","はい、私（わたし）もそう思（おも）います。"]', 3, '第（だい）21課（か）・即時応答（そくじおうとう）: そう思（おも）います naturally agrees with the prediction.', '来週（らいしゅう）は暖（あたた）かくなると思（おも）いますか。'),
('n5-s4-q65', 'n5-set-4', 'N5', 'listening', TRUE, 65, 'いちばん自然（しぜん）な返事（へんじ）を選（えら）んでください。', 'Choose the response that identifies the modified noun.', '["いいえ、ありません。","三時（さんじ）です。","駅（えき）で買（か）った傘（かさ）です。","はい、買（か）います。"]', 2, '第（だい）22課（か）・即時応答（そくじおうとう）: The answer identifies the item with a noun-modifying clause.', 'どれがあなたのものですか。'),
('n5-s4-q66', 'n5-set-4', 'N5', 'listening', TRUE, 66, 'いちばん自然（しぜん）な返事（へんじ）を選（えら）んでください。', 'Choose the response describing the result.', '["七時（しちじ）からです。","電気（でんき）がつきます。","昨日（きのう）しました。","三人（さんにん）です。"]', 1, '第（だい）23課（か）・即時応答（そくじおうとう）: The response states what happens as a result.', 'このスイッチを入（い）れると、どうなりますか。'),
('n5-s4-q67', 'n5-set-4', 'N5', 'listening', TRUE, 67, 'いちばん自然（しぜん）な返事（へんじ）を選（えら）んでください。', 'Choose the response naming the helper.', '["姉（あね）が手伝（てつだ）ってくれました。","姉（あね）を手伝（てつだ）いましたか。","姉（あね）に手伝（てつだ）います。","姉（あね）で手伝（てつだ）いません。"]', 0, '第（だい）24課（か）・即時応答（そくじおうとう）: The が-marked person is the giver of the helpful action.', 'だれが手伝（てつだ）ってくれましたか。'),
('n5-s5-q1', 'n5-set-5', 'N5', 'vocabulary', TRUE, 1, '手紙（てがみ）を出（だ）すところは＿＿です。', 'The place where you mail a letter is the post office.', '["郵便局（ゆうびんきょく）","食堂（しょくどう）","教室（きょうしつ）","売（う）り場（ば）"]', 0, '第（だい）3課（か）・文脈語彙（ぶんみゃくごい）: 郵便局（ゆうびんきょく）で手紙（てがみ）を出（だ）します。', NULL),
('n5-s5-q2', 'n5-set-5', 'N5', 'vocabulary', TRUE, 2, 'このかばんは大（おお）きくありません。＿＿です。', 'This bag is not big. It is small.', '["小（ちい）さい","高（たか）い","新（あたら）しい","重（おも）い"]', 0, '第（だい）8課（か）・文脈語彙（ぶんみゃくごい）: 小（ちい）さい is the opposite of 大（おお）きい.', NULL),
('n5-s5-q3', 'n5-set-5', 'N5', 'grammar-reading', TRUE, 3, '＿＿本（ほん）は私（わたし）のです。', 'That book near you is mine.', '["その","それ","そこ","あそこ"]', 0, '第（だい）2課（か）・文法形式（ぶんぽうけいしき）: その modifies the following noun 本（ほん）.', NULL),
('n5-s5-q4', 'n5-set-5', 'N5', 'grammar-reading', TRUE, 4, '公園（こうえん）に子供（こども）が＿＿。', 'There are children in the park.', '["います","あります","します","なります"]', 0, '第（だい）10課（か）・文法形式（ぶんぽうけいしき）: います is used for living things.', NULL),
('n5-s5-q5', 'n5-set-5', 'N5', 'listening', TRUE, 5, '二人（ふたり）は何時（なんじ）に会（あ）いますか。', 'What time will the two people meet?', '["二時（にじ）","三時（さんじ）","四時（よじ）","五時（ごじ）"]', 2, '第（だい）4課（か）・課題理解（かだいりかい）: 四時（よじ）に会（あ）います。', '三時（さんじ）は仕事（しごと）があります。四時（よじ）に駅（えき）で会（あ）いましょう。'),
('n5-s5-q6', 'n5-set-5', 'N5', 'listening', TRUE, 6, '女（おんな）の人（ひと）はりんごをいくつ買（か）いますか。', 'How many apples will the woman buy?', '["一（ひと）つ","二（ふた）つ","三（みっ）つ","四（よっ）つ"]', 2, '第（だい）11課（か）・要点理解（ようてんりかい）: りんごを三（みっ）つ買（か）います。', 'りんごを三（みっ）つと、みかんを二（ふた）つください。'),
('n5-s5-q7', 'n5-set-5', 'N5', 'vocabulary', TRUE, 7, '来週、奈良（なら）へ行（い）きます。
「来週」の読（よ）み方（かた）を選（えら）んでください。', 'Choose the reading of 来週.', '["きしゅう","らいじゅう","らいしゅう","らいしゅ"]', 2, '第（だい）5課（か）・漢字読（かんじよ）み: 「来週」は「らいしゅう」と読（よ）みます。', NULL),
('n5-s5-q8', 'n5-set-5', 'N5', 'vocabulary', TRUE, 8, '明日（あした）は妹（いもうと）の誕生日です。
「誕生日」の読（よ）み方（かた）を選（えら）んでください。', 'Choose the reading of 誕生日.', '["たんじょび","たんじょうび","だんじょうび","たんせいび"]', 1, '第（だい）11課（か）・漢字読（かんじよ）み: 「誕生日」は「たんじょうび」と読（よ）みます。', NULL),
('n5-s5-q9', 'n5-set-5', 'N5', 'vocabulary', TRUE, 9, '家族（かぞく）の写真を見（み）せました。
「写真」の読（よ）み方（かた）を選（えら）んでください。', 'Choose the reading of 写真.', '["しゃしん","しゃじん","さしん","しゃし"]', 0, '第（だい）7課（か）・漢字読（かんじよ）み: 「写真」は「しゃしん」と読（よ）みます。', NULL),
('n5-s5-q10', 'n5-set-5', 'N5', 'vocabulary', TRUE, 10, '郵便局（ゆうびんきょく）は銀行（ぎんこう）の右です。
「右」の読（よ）み方（かた）を選（えら）んでください。', 'Choose the reading of 右.', '["ひだり","うえ","した","みぎ"]', 3, '第（だい）10課（か）・漢字読（かんじよ）み: 「右」は「みぎ」と読（よ）みます。', NULL),
('n5-s5-q11', 'n5-set-5', 'N5', 'vocabulary', TRUE, 11, '本屋（ほんや）は駅（えき）の左です。
「左」の読（よ）み方（かた）を選（えら）んでください。', 'Choose the reading of 左.', '["まえ","そと","ひだり","みぎ"]', 2, '第（だい）10課（か）・漢字読（かんじよ）み: 「左」は「ひだり」と読（よ）みます。', NULL),
('n5-s5-q12', 'n5-set-5', 'N5', 'vocabulary', TRUE, 12, '外に男（おとこ）の人（ひと）がいます。
「外」の読（よ）み方（かた）を選（えら）んでください。', 'Choose the reading of 外.', '["よこ","そと","なか","うち"]', 1, '第（だい）10課（か）・漢字読（かんじよ）み: 「外」は「そと」と読（よ）みます。', NULL),
('n5-s5-q13', 'n5-set-5', 'N5', 'vocabulary', TRUE, 13, '箱（はこ）の中に何（なに）がありますか。
「中」の読（よ）み方（かた）を選（えら）んでください。', 'Choose the reading of 中.', '["なか","そと","ちゅ","うえ"]', 0, '第（だい）10課（か）・漢字読（かんじよ）み: 「中」は「なか」と読（よ）みます。', NULL),
('n5-s5-q14', 'n5-set-5', 'N5', 'vocabulary', TRUE, 14, '『いま』何時（なんじ）ですか。
『いま』の漢字（かんじ）を選（えら）んでください。', 'Choose the kanji for いま.', '["会","合","分","今"]', 3, '第（だい）4課（か）・表記（ひょうき）: 『いま』は「今」と書（か）きます。', NULL),
('n5-s5-q15', 'n5-set-5', 'N5', 'vocabulary', TRUE, 15, '『きょう』大阪（おおさか）へ行（い）きます。
『きょう』の漢字（かんじ）を選（えら）んでください。', 'Choose the kanji for きょう.', '["昨日","毎日","今日","明日"]', 2, '第（だい）5課（か）・表記（ひょうき）: 『きょう』は「今日」と書（か）きます。', NULL),
('n5-s5-q16', 'n5-set-5', 'N5', 'vocabulary', TRUE, 16, '『あした』友達（ともだち）に会（あ）います。
『あした』の漢字（かんじ）を選（えら）んでください。', 'Choose the kanji for あした.', '["休日","明日","昨日","今日"]', 1, '第（だい）5課（か）・表記（ひょうき）: 『あした』は「明日」と書（か）きます。', NULL),
('n5-s5-q17', 'n5-set-5', 'N5', 'vocabulary', TRUE, 17, '部屋（へや）の『そと』にいます。
『そと』の漢字（かんじ）を選（えら）んでください。', 'Choose the kanji for そと.', '["外","内","中","間"]', 0, '第（だい）10課（か）・表記（ひょうき）: 『そと』は「外」と書（か）きます。', NULL),
('n5-s5-q18', 'n5-set-5', 'N5', 'vocabulary', TRUE, 18, '受付（うけつけ）は二『かい』です。
『かい』の漢字（かんじ）を選（えら）んでください。', 'Choose the kanji for かい.', '["回","会","海","階"]', 3, '第（だい）3課（か）・表記（ひょうき）: 『かい』は「階」と書（か）きます。', NULL),
('n5-s5-q19', 'n5-set-5', 'N5', 'vocabulary', TRUE, 19, 'お金（かね）を下（お）ろしに＿＿へ行（い）きます。', 'Choose the word that best completes the sentence.', '["食堂（しょくどう）","公園（こうえん）","銀行（ぎんこう）","図書館（としょかん）"]', 2, '第（だい）3課（か）・文脈語彙（ぶんみゃくごい）: A bank is used to withdraw money.', NULL),
('n5-s5-q20', 'n5-set-5', 'N5', 'vocabulary', TRUE, 20, '音楽（おんがく）を＿＿。', 'Choose the word that best completes the sentence.', '["飲（の）みます","聞（き）きます","見（み）ます","読（よ）みます"]', 1, '第（だい）6課（か）・文脈語彙（ぶんみゃくごい）: Music is listened to with 聞（き）きます.', NULL),
('n5-s5-q21', 'n5-set-5', 'N5', 'vocabulary', TRUE, 21, 'この荷物（にもつ）はとても＿＿です。', 'Choose the word that best completes the sentence.', '["重（おも）い","狭（せま）い","低（ひく）い","短（みじか）い"]', 0, '第（だい）8課（か）・文脈語彙（ぶんみゃくごい）: 重（おも）い describes a heavy object.', NULL),
('n5-s5-q22', 'n5-set-5', 'N5', 'vocabulary', TRUE, 22, '教室（きょうしつ）に学生（がくせい）が＿＿います。', 'Choose the word that best completes the sentence.', '["五枚（ごまい）","五台（ごだい）","五本（ごほん）","五人（ごにん）"]', 3, '第（だい）11課（か）・文脈語彙（ぶんみゃくごい）: 人（にん） counts people.', NULL),
('n5-s5-q23', 'n5-set-5', 'N5', 'vocabulary', TRUE, 23, '駅（えき）まで歩（ある）いて十五分（じゅうごふん）かかります。
同（おな）じ意味（いみ）の文（ぶん）を選（えら）んでください。', 'Choose the sentence with the same meaning.', '["駅（えき）まで十五分（じゅうごふん）走（はし）ります。","駅（えき）から十五分（じゅうごふん）歩（ある）きました。","駅（えき）は歩（ある）いて十五分（じゅうごふん）のところです。","駅（えき）で十五分（じゅうごふん）待（ま）ちます。"]', 2, '第（だい）5課（か）・言（い）い換（か）え: Both sentences say the station is a fifteen-minute walk away.', NULL),
('n5-s5-q24', 'n5-set-5', 'N5', 'vocabulary', TRUE, 24, 'この部屋（へや）は明（あか）るくありません。
同（おな）じ意味（いみ）の文（ぶん）を選（えら）んでください。', 'Choose the sentence with the same meaning.', '["この部屋（へや）は新（あたら）しいです。","この部屋（へや）は暗（くら）いです。","この部屋（へや）は広（ひろ）いです。","この部屋（へや）は静（しず）かです。"]', 1, '第（だい）8課（か）・言（い）い換（か）え: 暗（くら）い is the opposite of 明（あか）るい.', NULL),
('n5-s5-q25', 'n5-set-5', 'N5', 'vocabulary', TRUE, 25, '会議（かいぎ）は二時間（にじかん）です。
同（おな）じ意味（いみ）の文（ぶん）を選（えら）んでください。', 'Choose the sentence with the same meaning.', '["会議（かいぎ）は二時間（にじかん）かかります。","会議（かいぎ）は二時（にじ）からです。","会議（かいぎ）は二回（にかい）あります。","会議（かいぎ）は二人（ふたり）です。"]', 0, '第（だい）11課（か）・言（い）い換（か）え: A two-hour meeting takes two hours.', NULL),
('n5-s5-q26', 'n5-set-5', 'N5', 'grammar-reading', TRUE, 26, '＿＿は写真（しゃしん）です。私（わたし）の近（ちか）くにあります。', 'This near me is a photograph.', '["この","ここ","どれ","これ"]', 3, '第（だい）2課（か）・文法形式（ぶんぽうけいしき）: これ refers to a thing near the speaker and stands alone.', NULL),
('n5-s5-q27', 'n5-set-5', 'N5', 'grammar-reading', TRUE, 27, '鈴木（すずき）は六時（ろくじ）＿＿起（お）きます。', '鈴木（すずき） gets up at 六時（ろくじ）.', '["を","へ","に","で"]', 2, '第（だい）4課（か）・文法形式（ぶんぽうけいしき）: に marks a specific time.', NULL),
('n5-s5-q28', 'n5-set-5', 'N5', 'grammar-reading', TRUE, 28, '日本語（にほんご）＿＿手紙（てがみ）を書（か）きます。', 'I write a letter in Japanese.', '["へ","で","を","に"]', 1, '第（だい）7課（か）・文法形式（ぶんぽうけいしき）: で marks the language or means used.', NULL),
('n5-s5-q29', 'n5-set-5', 'N5', 'grammar-reading', TRUE, 29, '銀行（ぎんこう）＿＿田中（たなか）がいます。', '田中（たなか） is at the 銀行（ぎんこう）.', '["に","を","で","へ"]', 0, '第（だい）10課（か）・文法形式（ぶんぽうけいしき）: に marks the place where a person exists.', NULL),
('n5-s5-q30', 'n5-set-5', 'N5', 'grammar-reading', TRUE, 30, 'すみません。ゆっくり話（はな）して＿＿。', 'Please do the requested action.', '["います","あります","なります","ください"]', 3, '第（だい）14課（か）・文法形式（ぶんぽうけいしき）: The て-form plus ください makes a polite request.', NULL),
('n5-s5-q31', 'n5-set-5', 'N5', 'grammar-reading', TRUE, 31, '明日（あした）までに切符（きっぷ）を買（か）わなければ＿＿。', 'The action must be completed by tomorrow.', '["いけます","ください","なりません","ありません"]', 2, '第（だい）17課（か）・文法形式（ぶんぽうけいしき）: ない-form without い + ければなりません expresses obligation.', NULL),
('n5-s5-q32', 'n5-set-5', 'N5', 'grammar-reading', TRUE, 32, '仕事（しごと）が＿＿、家（いえ）へ帰（かえ）ります。', 'Choose the たら conditional form.', '["終（お）わるまで","終（お）わったら","終（お）わっても","終（お）わりますから"]', 1, '第（だい）25課（か）・文法形式（ぶんぽうけいしき）: The たら form expresses a condition for the following action.', NULL)
ON DUPLICATE KEY UPDATE
  set_id = VALUES(set_id),
  level = VALUES(level),
  section = VALUES(section),
  active = VALUES(active),
  order_no = VALUES(order_no),
  prompt = VALUES(prompt),
  prompt_en = VALUES(prompt_en),
  options = VALUES(options),
  answer_index = VALUES(answer_index),
  explanation = VALUES(explanation),
  audio_text = VALUES(audio_text),
  updated_at = CURRENT_TIMESTAMP(3);

INSERT INTO questions
  (id, set_id, level, section, active, order_no, prompt, prompt_en, options, answer_index, explanation, audio_text)
VALUES
('n5-s5-q33', 'n5-set-5', 'N5', 'grammar-reading', TRUE, 33, '買（か）い物（もの）の順番（じゅんばん）として正（ただ）しい文（ぶん）はどれですか。', 'Choose the correctly formed sentence.', '["店（みせ）へ行（い）って、野菜（やさい）を選（えら）んで、お金（かね）を払（はら）います。","店（みせ）へ行（い）きて、野菜（やさい）を選（えら）んで、お金（かね）を払（はら）います。","店（みせ）へ行（い）って、野菜（やさい）を選（えら）びて、お金（かね）を払（はら）います。","店（みせ）へ行（い）くて、野菜（やさい）を選（えら）んで、お金（かね）を払（はら）います。"]', 0, '第（だい）16課（か）・文（ぶん）の組（く）み立（た）て: Correct て-forms connect the shopping actions.', NULL),
('n5-s5-q34', 'n5-set-5', 'N5', 'grammar-reading', TRUE, 34, '正（ただ）しい文（ぶん）を選（えら）んでください。', 'Choose the correctly formed sentence.', '["会社（かいしゃ）へ行（い）った前（まえ）に、新聞（しんぶん）を読（よ）みます。","会社（かいしゃ）へ行（い）き前（まえ）に、新聞（しんぶん）を読（よ）みます。","会社（かいしゃ）へ行（い）って前（まえ）に、新聞（しんぶん）を読（よ）みます。","会社（かいしゃ）へ行（い）く前（まえ）に、新聞（しんぶん）を読（よ）みます。"]', 3, '第（だい）18課（か）・文（ぶん）の組（く）み立（た）て: Dictionary form + 前（まえ）に expresses doing one action before another.', NULL),
('n5-s5-q35', 'n5-set-5', 'N5', 'grammar-reading', TRUE, 35, '経験（けいけん）について正（ただ）しい文（ぶん）はどれですか。', 'Choose the correctly formed sentence.', '["着物（きもの）を着（き）てことがあります。","着物（きもの）を着（き）ますことがあります。","着物（きもの）を着（き）たことがあります。","着物（きもの）を着（き）ることがありました。"]', 2, '第（だい）19課（か）・文（ぶん）の組（く）み立（た）て: Past form + ことがあります expresses experience.', NULL),
('n5-s5-q36', 'n5-set-5', 'N5', 'grammar-reading', TRUE, 36, '伝言（でんごん）として正（ただ）しい文（ぶん）はどれですか。', 'Choose the correctly formed sentence.', '["母（はは）は遅（おそ）くなるを言（い）いました。","母（はは）は遅（おそ）くなると言（い）いました。","母（はは）は遅（おそ）くなりますと言（い）いました。","母（はは）は遅（おそ）くなってと言（い）いました。"]', 1, '第（だい）21課（か）・文（ぶん）の組（く）み立（た）て: Plain form + と言（い）いました reports what someone said.', NULL),
('n5-s5-q37', 'n5-set-5', 'N5', 'grammar-reading', TRUE, 37, '弟（おとうと）が聞（き）きました。『このケーキ、＿＿？』', 'Choose the grammar that best completes the text.', '["おいしい","おいしいです","おいしくです","おいしかったですか"]', 0, '第（だい）20課（か）・文章文法（ぶんしょうぶんぽう）: A casual non-past adjective question uses the plain form.', NULL),
('n5-s5-q38', 'n5-set-5', 'N5', 'grammar-reading', TRUE, 38, '道（みち）を渡（わた）る＿＿、車（くるま）を見（み）てください。', 'Choose the grammar that best completes the text.', '["ので","まで","だけ","とき"]', 3, '第（だい）23課（か）・文章文法（ぶんしょうぶんぽう）: Dictionary form + とき describes the time before crossing.', NULL),
('n5-s5-q39', 'n5-set-5', 'N5', 'grammar-reading', TRUE, 39, '私（わたし）は父（ちち）に自転車（じてんしゃ）を直（なお）して＿＿。', 'Choose the grammar that best completes the text.', '["くれましたか","しました","もらいました","あげました"]', 2, '第（だい）24課（か）・文章文法（ぶんしょうぶんぽう）: て-form + もらいました means receiving the favor of repair.', NULL),
('n5-s5-q40', 'n5-set-5', 'N5', 'grammar-reading', TRUE, 40, '短（みじか）い文章（ぶんしょう）を読（よ）んでください。
鈴木（すずき）さんは毎晩（まいばん）十時（じゅうじ）まで勉強（べんきょう）します。その後（あと）で本（ほん）を三十分（さんじゅっぷん）読（よ）んで、十一時（じゅういちじ）に寝（ね）ます。
鈴木（すずき）さんは何時（なんじ）に寝（ね）ますか。', 'Suzuki studies until 10, reads for thirty minutes, and goes to bed at 11. When does Suzuki sleep?', '["十二時（じゅうにじ）","十一時（じゅういちじ）","十時（じゅうじ）","十時半（じゅうじはん）"]', 1, '第（だい）4課（か）・読解（どっかい）: The passage says bedtime is eleven.', NULL),
('n5-s5-q41', 'n5-set-5', 'N5', 'grammar-reading', TRUE, 41, 'メールを読（よ）んでください。
田中（たなか）さんへ
金曜日（きんようび）の夜（よる）、新（あたら）しいレストランへ食（た）べに行（い）きませんか。七時（しちじ）に駅（えき）で会（あ）いましょう。
鈴木（すずき）
二人（ふたり）は何（なに）をしに行（い）きますか。', 'Suzuki invites Tanaka to a new restaurant Friday at 7. What will they go to do?', '["ご飯（はん）を食（た）べに行（い）きます。","映画（えいが）を見（み）に行（い）きます。","本（ほん）を買（か）いに行（い）きます。","勉強（べんきょう）しに行（い）きます。"]', 0, '第（だい）13課（か）・読解（どっかい）: The purpose is eating at a restaurant.', NULL),
('n5-s5-q42', 'n5-set-5', 'N5', 'grammar-reading', TRUE, 42, 'プールのお知（し）らせ
午前（ごぜん）の部（ぶ）：九時（くじ）から十二時（じゅうにじ）
午後（ごご）の部（ぶ）：二時（にじ）から六時（ろくじ）
水曜日（すいようび）：休（やす）み
泳（およ）げるのはいつですか。', 'Pool sessions are 9–12 and 2–6, closed Wednesday. When can someone swim?', '["水曜日（すいようび）の午前十時（ごぜんじゅうじ）","月曜日（げつようび）の午後一時（ごごいちじ）","金曜日（きんようび）の午後七時（ごごしちじ）","火曜日（かようび）の午後三時（ごごさんじ）"]', 3, '第（だい）11課（か）・読解（どっかい）: Tuesday at 3:00 is inside the afternoon session.', NULL),
('n5-s5-q43', 'n5-set-5', 'N5', 'grammar-reading', TRUE, 43, '春（はる）は暖（あたた）かくて、花（はな）がきれいです。冬（ふゆ）は寒（さむ）いですが、雪（ゆき）が好（す）きな人（ひと）に人気（にんき）があります。
花（はな）がきれいな季節（きせつ）はいつですか。', 'Spring is warm with beautiful flowers; winter is cold and popular with snow lovers. Which season has beautiful flowers?', '["秋（あき）","夏（なつ）","春（はる）","冬（ふゆ）"]', 2, '第（だい）12課（か）・読解（どっかい）: The passage associates beautiful flowers with spring.', NULL),
('n5-s5-q44', 'n5-set-5', 'N5', 'grammar-reading', TRUE, 44, '母（はは）が作（つく）ったケーキは冷蔵庫（れいぞうこ）の中（なか）です。店（みせ）で買（か）ったパンは机（つくえ）の上（うえ）です。
冷蔵庫（れいぞうこ）にあるものは何（なん）ですか。', 'Mother''s cake is in the refrigerator; store-bought bread is on the desk. What is in the refrigerator?', '["父（ちち）が買（か）ったケーキ","母（はは）が作（つく）ったケーキ","店（みせ）で買（か）ったパン","友達（ともだち）が作（つく）ったパン"]', 1, '第（だい）22課（か）・読解（どっかい）: The cake made by the mother is in the refrigerator.', NULL),
('n5-s5-q45', 'n5-set-5', 'N5', 'grammar-reading', TRUE, 45, '会社（かいしゃ）からのお知（し）らせ
会議（かいぎ）は十時（じゅうじ）からです。九時五十分（くじごじゅっぷん）までに部屋（へや）へ来（こ）なければなりません。飲（の）み物（もの）を持（も）って来（き）てもいいです。
何時（なんじ）までに部屋（へや）へ行（い）きますか。', 'The meeting starts at 10 and employees must arrive by 9:50; drinks are allowed. By when must they arrive?', '["九時五十分（くじごじゅっぷん）","十時（じゅうじ）","九時（くじ）","十時五十分（じゅうじごじゅっぷん）"]', 0, '第（だい）17課（か）・読解（どっかい）: The notice requires arrival by 9:50.', NULL),
('n5-s5-q46', 'n5-set-5', 'N5', 'listening', TRUE, 46, '男（おとこ）の人（ひと）はどこへ行（い）きますか。', 'Listen and choose what the person will do.', '["食堂（しょくどう）","病院（びょういん）","郵便局（ゆうびんきょく）","図書館（としょかん）"]', 3, '第（だい）3課（か）・課題理解（かだいりかい）: He goes to return a library book.', 'この本（ほん）を今日（きょう）返（かえ）さなければなりません。図書館（としょかん）へ行（い）きます。'),
('n5-s5-q47', 'n5-set-5', 'N5', 'listening', TRUE, 47, '女（おんな）の人（ひと）は何（なに）で学校（がっこう）へ行（い）きますか。', 'Listen and choose what the person will do.', '["電車（でんしゃ）","車（くるま）","自転車（じてんしゃ）","バス"]', 2, '第（だい）5課（か）・課題理解（かだいりかい）: She cycles to school.', '学校（がっこう）は家（いえ）から近（ちか）いです。毎日（まいにち）、自転車（じてんしゃ）で行（い）きます。'),
('n5-s5-q48', 'n5-set-5', 'N5', 'listening', TRUE, 48, '男（おとこ）の人（ひと）は父（ちち）に何（なに）を見（み）せますか。', 'Listen and choose what the person will do.', '["地図（ちず）","写真（しゃしん）","宿題（しゅくだい）","時計（とけい）"]', 1, '第（だい）7課（か）・課題理解（かだいりかい）: He shows his father travel photographs.', '旅行（りょこう）で写真（しゃしん）をたくさん撮（と）りました。父（ちち）に見（み）せます。'),
('n5-s5-q49', 'n5-set-5', 'N5', 'listening', TRUE, 49, '女（おんな）の人（ひと）は卵（たまご）をいくつ買（か）いますか。', 'Listen and choose what the person will do.', '["六（むっ）つ","四（よっ）つ","五（いつ）つ","七（なな）つ"]', 0, '第（だい）11課（か）・課題理解（かだいりかい）: She needs six eggs.', 'ケーキを二（ふた）つ作（つく）ります。卵（たまご）は六（むっ）ついります。'),
('n5-s5-q50', 'n5-set-5', 'N5', 'listening', TRUE, 50, '二人（ふたり）は何（なに）をしに店（みせ）へ行（い）きますか。', 'Listen and choose what the person will do.', '["ご飯（はん）を食（た）べます","仕事（しごと）をします","荷物（にもつ）を送（おく）ります","誕生日（たんじょうび）のプレゼントを買（か）います"]', 3, '第（だい）13課（か）・課題理解（かだいりかい）: They will buy a birthday present.', '明日（あした）は田中（たなか）さんの誕生日（たんじょうび）です。プレゼントを買（か）いに行（い）きましょう。'),
('n5-s5-q51', 'n5-set-5', 'N5', 'listening', TRUE, 51, '授業（じゅぎょう）は何時（なんじ）に終（お）わりますか。', 'Listen and choose the key detail.', '["四時半（よじはん）","五時（ごじ）","四時四十分（よじよんじゅっぷん）","四時（よじ）"]', 2, '第（だい）4課（か）・要点理解（ようてんりかい）: Today''s class ends at 4:40.', '授業（じゅぎょう）は四時半（よじはん）までの予定（よてい）でしたが、今日（きょう）は四時四十分（よじよんじゅっぷん）に終（お）わります。'),
('n5-s5-q52', 'n5-set-5', 'N5', 'listening', TRUE, 52, '女（おんな）の人（ひと）は何（なに）を飲（の）みますか。', 'Listen and choose the key detail.', '["牛乳（ぎゅうにゅう）","水（みず）","お茶（ちゃ）","コーヒー"]', 1, '第（だい）6課（か）・要点理解（ようてんりかい）: She drinks water after exercise.', '運動（うんどう）の後（あと）ですから、水（みず）をたくさん飲（の）みます。'),
('n5-s5-q53', 'n5-set-5', 'N5', 'listening', TRUE, 53, '男（おとこ）の人（ひと）はどの自転車（じてんしゃ）を買（か）いますか。', 'Listen and choose the key detail.', '["新（あたら）しい自転車（じてんしゃ）","古（ふる）い自転車（じてんしゃ）","高（たか）い自転車（じてんしゃ）","小（ちい）さい自転車（じてんしゃ）"]', 0, '第（だい）8課（か）・要点理解（ようてんりかい）: He chooses the new bicycle.', '古（ふる）い自転車（じてんしゃ）は安（やす）いですが、こちらの新（あたら）しい自転車（じてんしゃ）にします。'),
('n5-s5-q54', 'n5-set-5', 'N5', 'listening', TRUE, 54, '女（おんな）の人（ひと）はどうして電車（でんしゃ）で行（い）きますか。', 'Listen and choose the key detail.', '["電車（でんしゃ）が嫌（きら）いですから","駅（えき）が遠（とお）いですから","歩（ある）くのが好（す）きですから","車（くるま）がありませんから"]', 3, '第（だい）9課（か）・要点理解（ようてんりかい）: She has no car.', '車（くるま）がありませんから、電車（でんしゃ）で行（い）きます。'),
('n5-s5-q55', 'n5-set-5', 'N5', 'listening', TRUE, 55, '昨日（きのう）のレストランはどうでしたか。', 'Listen and choose the key detail.', '["安（やす）かったです","狭（せま）くなかったです","にぎやかでした","静（しず）かでした"]', 2, '第（だい）12課（か）・要点理解（ようてんりかい）: Many customers made it lively.', '人（ひと）がたくさんいて、昨日（きのう）のレストランはにぎやかでした。'),
('n5-s5-q56', 'n5-set-5', 'N5', 'listening', TRUE, 56, '初（はじ）めて会（あ）う人（ひと）に何（なん）と言（い）いますか。', 'What do you say when meeting someone for the first time?', '["お大事（だいじ）に。","初（はじ）めまして。","いただきます。","お帰（かえ）りなさい。"]', 1, '第（だい）1課（か）・発話表現（はつわひょうげん）: 初（はじ）めまして is used at a first meeting.', 'あなたはスリランカから来（き）ました。初（はじ）めて鈴木（すずき）に会（あ）います。何（なん）と言（い）いますか。'),
('n5-s5-q57', 'n5-set-5', 'N5', 'listening', TRUE, 57, '店（みせ）で値段（ねだん）を聞（き）きます。何（なん）と言（い）いますか。', 'What do you say to ask the price in a shop?', '["この写真（しゃしん）はいくらですか。","この写真（しゃしん）はどこですか。","この写真（しゃしん）はだれですか。","この写真（しゃしん）はいつですか。"]', 0, '第（だい）2課（か）・発話表現（はつわひょうげん）: いくら asks a price.', '店（みせ）でこの写真（しゃしん）の値段（ねだん）を知（し）りたいです。何（なん）と言（い）いますか。'),
('n5-s5-q58', 'n5-set-5', 'N5', 'listening', TRUE, 58, '丁寧（ていねい）にお願（ねが）いします。何（なん）と言（い）いますか。', 'Which expression makes the polite request?', '["ゆっくり話（はな）すません。","ゆっくり話（はな）すことがあります。","ゆっくり話（はな）すたいです。","ゆっくり話（はな）してください。"]', 3, '第（だい）14課（か）・発話表現（はつわひょうげん）: The て-form plus ください makes a polite request.', '田中（たなか）にゆっくり話（はな）すことをお願（ねが）いします。何（なん）と言（い）いますか。'),
('n5-s5-q59', 'n5-set-5', 'N5', 'listening', TRUE, 59, '許可（きょか）を聞（き）きます。何（なん）と言（い）いますか。', 'What do you say to ask permission?', '["入口（いりぐち）の横（よこ）に座（すわ）らないでください。","入口（いりぐち）の横（よこ）に座（すわ）らなければなりません。","入口（いりぐち）の横（よこ）に座（すわ）ってもいいですか。","入口（いりぐち）の横（よこ）に座（すわ）ってはいけません。"]', 2, '第（だい）15課（か）・発話表現（はつわひょうげん）: て-form + もいいですか asks permission.', '入口（いりぐち）の横（よこ）に座（すわ）りたいです。先生（せんせい）に何（なん）と言（い）いますか。'),
('n5-s5-q60', 'n5-set-5', 'N5', 'listening', TRUE, 60, '手伝（てつだ）いを申（もう）し出（で）ます。何（なん）と言（い）いますか。', 'What do you say to offer help?', '["この椅子（いす）を持（も）たないでください。","この椅子（いす）を持（も）ちましょうか。","この椅子（いす）を持（も）ってはいけません。","この椅子（いす）を持（も）ちたいですか。"]', 1, '第（だい）16課（か）・発話表現（はつわひょうげん）: Verb stem + ましょうか can offer assistance.', '鈴木（すずき）がこの椅子（いす）を運（はこ）んでいます。手伝（てつだ）いたいです。何（なん）と言（い）いますか。'),
('n5-s5-q61', 'n5-set-5', 'N5', 'listening', TRUE, 61, '友達（ともだち）の助（たす）けにお礼（れい）を言（い）います。何（なん）と言（い）いますか。', 'What do you say to thank a friend for helping?', '["宿題（しゅくだい）を見（み）てくれて、ありがとう。","宿題（しゅくだい）を見（み）てはいけません。","宿題（しゅくだい）を見（み）てくださいか。","宿題（しゅくだい）を見（み）てありません。"]', 0, '第（だい）24課（か）・発話表現（はつわひょうげん）: てくれてありがとう thanks someone for a helpful action.', '田中（たなか）が宿題（しゅくだい）を見（み）てくれました。何（なん）と言（い）いますか。'),
('n5-s5-q62', 'n5-set-5', 'N5', 'listening', TRUE, 62, 'いちばん自然（しぜん）な返事（へんじ）を選（えら）んでください。', 'Choose the most natural response.', '["はい、います。","いいえ、ありませんでしたか。","いいえ、します。","はい、あります。"]', 3, '第（だい）19課（か）・即時応答（そくじおうとう）: はい、あります answers an experience question.', '新幹線（しんかんせん）に乗（の）ったことがありますか。'),
('n5-s5-q63', 'n5-set-5', 'N5', 'listening', TRUE, 63, 'いちばん自然（しぜん）な返事（へんじ）を選（えら）んでください。', 'Choose the most natural casual response.', '["いいえ、行（い）きました。","うん、ありません。","うん、いいよ。","はい、いいですか。"]', 2, '第（だい）20課（か）・即時応答（そくじおうとう）: うん、いいよ is a natural casual acceptance.', '今（いま）から図書館（としょかん）へ行（い）く？'),
('n5-s5-q64', 'n5-set-5', 'N5', 'listening', TRUE, 64, 'いちばん自然（しぜん）な返事（へんじ）を選（えら）んでください。', 'Choose the most natural response to an opinion question.', '["はい、思（おも）いでした。","はい、私（わたし）もそう思（おも）います。","はい、そう言（い）いましたか。","いいえ、思（おも）ってください。"]', 1, '第（だい）21課（か）・即時応答（そくじおうとう）: そう思（おも）います naturally agrees with the prediction.', '田中（たなか）さんは会議（かいぎ）に来（く）ると思（おも）いますか。'),
('n5-s5-q65', 'n5-set-5', 'N5', 'listening', TRUE, 65, 'いちばん自然（しぜん）な返事（へんじ）を選（えら）んでください。', 'Choose the response that identifies the modified noun.', '["先生（せんせい）が書（か）いた本（ほん）です。","はい、買（か）います。","いいえ、ありません。","三時（さんじ）です。"]', 0, '第（だい）22課（か）・即時応答（そくじおうとう）: The answer identifies the item with a noun-modifying clause.', 'どれがあなたのものですか。'),
('n5-s5-q66', 'n5-set-5', 'N5', 'listening', TRUE, 66, 'いちばん自然（しぜん）な返事（へんじ）を選（えら）んでください。', 'Choose the response describing the result.', '["昨日（きのう）しました。","三人（さんにん）です。","七時（しちじ）からです。","駅（えき）があります。"]', 3, '第（だい）23課（か）・即時応答（そくじおうとう）: The response states what happens as a result.', 'この道（みち）をまっすぐ行（い）くと、どうなりますか。'),
('n5-s5-q67', 'n5-set-5', 'N5', 'listening', TRUE, 67, 'いちばん自然（しぜん）な返事（へんじ）を選（えら）んでください。', 'Choose the response naming the helper.', '["先生（せんせい）に手伝（てつだ）います。","先生（せんせい）で手伝（てつだ）いません。","先生（せんせい）が手伝（てつだ）ってくれました。","先生（せんせい）を手伝（てつだ）いましたか。"]', 2, '第（だい）24課（か）・即時応答（そくじおうとう）: The が-marked person is the giver of the helpful action.', 'だれが手伝（てつだ）ってくれましたか。')
ON DUPLICATE KEY UPDATE
  set_id = VALUES(set_id),
  level = VALUES(level),
  section = VALUES(section),
  active = VALUES(active),
  order_no = VALUES(order_no),
  prompt = VALUES(prompt),
  prompt_en = VALUES(prompt_en),
  options = VALUES(options),
  answer_index = VALUES(answer_index),
  explanation = VALUES(explanation),
  audio_text = VALUES(audio_text),
  updated_at = CURRENT_TIMESTAMP(3);

COMMIT;
SET SQL_MODE = @OLD_SQL_MODE;

-- Every returned row must show 21, 22, 24, and 67.
SELECT
  set_id,
  SUM(section = 'vocabulary' AND active = TRUE) AS vocabulary_questions,
  SUM(section = 'grammar-reading' AND active = TRUE) AS grammar_reading_questions,
  SUM(section = 'listening' AND active = TRUE) AS listening_questions,
  SUM(active = TRUE) AS total_questions
FROM questions
WHERE set_id IN ('n5-set-1', 'n5-set-2', 'n5-set-3', 'n5-set-4', 'n5-set-5')
GROUP BY set_id
ORDER BY set_id;

-- This query must return zero rows. If it returns anything, do not publish the affected set.
SELECT set_id, order_no, COUNT(*) AS duplicate_count
FROM questions
WHERE set_id IN ('n5-set-1', 'n5-set-2', 'n5-set-3', 'n5-set-4', 'n5-set-5')
GROUP BY set_id, order_no
HAVING COUNT(*) > 1;
