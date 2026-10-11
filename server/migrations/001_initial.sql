CREATE TABLE IF NOT EXISTS users (
  firebase_uid TEXT PRIMARY KEY,
  email TEXT,
  display_name TEXT,
  photo_url TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  last_login_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS exam_sets (
  id TEXT PRIMARY KEY,
  level TEXT NOT NULL CHECK (level IN ('N5', 'N4', 'N3', 'N2', 'N1')),
  order_no INTEGER NOT NULL CHECK (order_no > 0),
  title TEXT NOT NULL,
  description TEXT NOT NULL DEFAULT '',
  active BOOLEAN NOT NULL DEFAULT TRUE,
  duration_minutes INTEGER NOT NULL DEFAULT 90 CHECK (duration_minutes > 0),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (level, order_no)
);

CREATE TABLE IF NOT EXISTS questions (
  id TEXT PRIMARY KEY,
  set_id TEXT NOT NULL REFERENCES exam_sets(id) ON DELETE CASCADE,
  level TEXT NOT NULL CHECK (level IN ('N5', 'N4', 'N3', 'N2', 'N1')),
  section TEXT NOT NULL CHECK (section IN ('vocabulary', 'grammar-reading', 'listening')),
  active BOOLEAN NOT NULL DEFAULT TRUE,
  order_no INTEGER NOT NULL CHECK (order_no > 0),
  prompt TEXT NOT NULL,
  prompt_en TEXT NOT NULL,
  options JSONB NOT NULL CHECK (jsonb_typeof(options) = 'array'),
  answer_index INTEGER NOT NULL CHECK (answer_index >= 0 AND answer_index < jsonb_array_length(options)),
  explanation TEXT NOT NULL,
  audio_text TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (set_id, order_no)
);

CREATE TABLE IF NOT EXISTS practice_completions (
  id BIGSERIAL PRIMARY KEY,
  firebase_uid TEXT NOT NULL REFERENCES users(firebase_uid) ON DELETE CASCADE,
  question_id TEXT NOT NULL REFERENCES questions(id) ON DELETE CASCADE,
  selected_index INTEGER NOT NULL CHECK (selected_index >= 0),
  correct BOOLEAN NOT NULL,
  completed_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS test_attempts (
  id UUID PRIMARY KEY,
  firebase_uid TEXT NOT NULL REFERENCES users(firebase_uid) ON DELETE CASCADE,
  set_id TEXT NOT NULL REFERENCES exam_sets(id) ON DELETE RESTRICT,
  section TEXT NOT NULL CHECK (section IN ('all', 'vocabulary', 'grammar-reading', 'listening')),
  status TEXT NOT NULL DEFAULT 'in_progress' CHECK (status IN ('in_progress', 'completed')),
  correct_count INTEGER CHECK (correct_count >= 0),
  total_count INTEGER NOT NULL CHECK (total_count > 0),
  percent INTEGER CHECK (percent BETWEEN 0 AND 100),
  started_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  completed_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS test_attempt_questions (
  attempt_id UUID NOT NULL REFERENCES test_attempts(id) ON DELETE CASCADE,
  question_id TEXT NOT NULL REFERENCES questions(id) ON DELETE RESTRICT,
  position INTEGER NOT NULL CHECK (position > 0),
  PRIMARY KEY (attempt_id, question_id),
  UNIQUE (attempt_id, position)
);

CREATE TABLE IF NOT EXISTS test_attempt_answers (
  attempt_id UUID NOT NULL REFERENCES test_attempts(id) ON DELETE CASCADE,
  question_id TEXT NOT NULL REFERENCES questions(id) ON DELETE RESTRICT,
  selected_index INTEGER CHECK (selected_index >= 0),
  correct BOOLEAN NOT NULL,
  answered_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  PRIMARY KEY (attempt_id, question_id)
);

CREATE TABLE IF NOT EXISTS user_best_scores (
  firebase_uid TEXT NOT NULL REFERENCES users(firebase_uid) ON DELETE CASCADE,
  set_id TEXT NOT NULL REFERENCES exam_sets(id) ON DELETE CASCADE,
  section TEXT NOT NULL CHECK (section IN ('all', 'vocabulary', 'grammar-reading', 'listening')),
  correct_count INTEGER NOT NULL CHECK (correct_count >= 0),
  total_count INTEGER NOT NULL CHECK (total_count > 0),
  percent INTEGER NOT NULL CHECK (percent BETWEEN 0 AND 100),
  attempt_id UUID NOT NULL REFERENCES test_attempts(id) ON DELETE RESTRICT,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  PRIMARY KEY (firebase_uid, set_id, section)
);

CREATE INDEX IF NOT EXISTS questions_active_lookup
  ON questions (level, section, set_id, order_no)
  WHERE active = TRUE;

CREATE INDEX IF NOT EXISTS practice_completions_user_time
  ON practice_completions (firebase_uid, completed_at DESC);

CREATE INDEX IF NOT EXISTS test_attempts_user_time
  ON test_attempts (firebase_uid, started_at DESC);
