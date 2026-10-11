CREATE TABLE IF NOT EXISTS users (
  firebase_uid VARCHAR(128) PRIMARY KEY,
  email VARCHAR(320),
  display_name VARCHAR(255),
  photo_url TEXT,
  created_at DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  updated_at DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  last_login_at DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS exam_sets (
  id VARCHAR(64) PRIMARY KEY,
  level ENUM('N5', 'N4', 'N3', 'N2', 'N1') NOT NULL,
  order_no INTEGER NOT NULL CHECK (order_no > 0),
  title VARCHAR(255) NOT NULL,
  description TEXT NOT NULL,
  active BOOLEAN NOT NULL DEFAULT TRUE,
  duration_minutes INTEGER NOT NULL DEFAULT 90 CHECK (duration_minutes > 0),
  created_at DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  updated_at DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  UNIQUE (level, order_no)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS questions (
  id VARCHAR(64) PRIMARY KEY,
  set_id VARCHAR(64) NOT NULL,
  level ENUM('N5', 'N4', 'N3', 'N2', 'N1') NOT NULL,
  section ENUM('vocabulary', 'grammar-reading', 'listening') NOT NULL,
  active BOOLEAN NOT NULL DEFAULT TRUE,
  order_no INTEGER NOT NULL CHECK (order_no > 0),
  prompt TEXT NOT NULL,
  prompt_en TEXT NOT NULL,
  options JSON NOT NULL,
  answer_index INTEGER NOT NULL CHECK (answer_index >= 0),
  explanation TEXT NOT NULL,
  audio_text TEXT,
  created_at DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  updated_at DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  UNIQUE (set_id, order_no),
  KEY questions_active_lookup (level, section, active, set_id, order_no),
  CONSTRAINT questions_set_fk FOREIGN KEY (set_id) REFERENCES exam_sets(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS practice_completions (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  firebase_uid VARCHAR(128) NOT NULL,
  question_id VARCHAR(64) NOT NULL,
  selected_index INTEGER NOT NULL CHECK (selected_index >= 0),
  correct BOOLEAN NOT NULL,
  completed_at DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  KEY practice_completions_user_time (firebase_uid, completed_at),
  CONSTRAINT practice_user_fk FOREIGN KEY (firebase_uid) REFERENCES users(firebase_uid) ON DELETE CASCADE,
  CONSTRAINT practice_question_fk FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS test_attempts (
  id CHAR(36) PRIMARY KEY,
  firebase_uid VARCHAR(128) NOT NULL,
  set_id VARCHAR(64) NOT NULL,
  section ENUM('all', 'vocabulary', 'grammar-reading', 'listening') NOT NULL,
  status ENUM('in_progress', 'completed') NOT NULL DEFAULT 'in_progress',
  correct_count INTEGER CHECK (correct_count >= 0),
  total_count INTEGER NOT NULL CHECK (total_count > 0),
  percent INTEGER CHECK (percent BETWEEN 0 AND 100),
  started_at DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  completed_at DATETIME(3),
  KEY test_attempts_user_time (firebase_uid, started_at),
  CONSTRAINT attempts_user_fk FOREIGN KEY (firebase_uid) REFERENCES users(firebase_uid) ON DELETE CASCADE,
  CONSTRAINT attempts_set_fk FOREIGN KEY (set_id) REFERENCES exam_sets(id) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS test_attempt_questions (
  attempt_id CHAR(36) NOT NULL,
  question_id VARCHAR(64) NOT NULL,
  position INTEGER NOT NULL CHECK (position > 0),
  PRIMARY KEY (attempt_id, question_id),
  UNIQUE (attempt_id, position),
  CONSTRAINT attempt_questions_attempt_fk FOREIGN KEY (attempt_id) REFERENCES test_attempts(id) ON DELETE CASCADE,
  CONSTRAINT attempt_questions_question_fk FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS test_attempt_answers (
  attempt_id CHAR(36) NOT NULL,
  question_id VARCHAR(64) NOT NULL,
  selected_index INTEGER CHECK (selected_index >= 0),
  correct BOOLEAN NOT NULL,
  answered_at DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (attempt_id, question_id),
  CONSTRAINT attempt_answers_attempt_fk FOREIGN KEY (attempt_id) REFERENCES test_attempts(id) ON DELETE CASCADE,
  CONSTRAINT attempt_answers_question_fk FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS user_best_scores (
  firebase_uid VARCHAR(128) NOT NULL,
  set_id VARCHAR(64) NOT NULL,
  section ENUM('all', 'vocabulary', 'grammar-reading', 'listening') NOT NULL,
  correct_count INTEGER NOT NULL CHECK (correct_count >= 0),
  total_count INTEGER NOT NULL CHECK (total_count > 0),
  percent INTEGER NOT NULL CHECK (percent BETWEEN 0 AND 100),
  attempt_id CHAR(36) NOT NULL,
  updated_at DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (firebase_uid, set_id, section),
  CONSTRAINT scores_user_fk FOREIGN KEY (firebase_uid) REFERENCES users(firebase_uid) ON DELETE CASCADE,
  CONSTRAINT scores_set_fk FOREIGN KEY (set_id) REFERENCES exam_sets(id) ON DELETE CASCADE,
  CONSTRAINT scores_attempt_fk FOREIGN KEY (attempt_id) REFERENCES test_attempts(id) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
