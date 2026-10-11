export default [
  {
    ignores: ["node_modules/**"],
    languageOptions: {
      ecmaVersion: "latest",
      sourceType: "module",
      globals: {
        Buffer: "readonly",
        console: "readonly",
        process: "readonly",
        setTimeout: "readonly",
        URL: "readonly",
      },
    },
    rules: {
      "no-undef": "error",
      "no-unused-vars": ["error", {"argsIgnorePattern": "^_"}],
    },
  },
];
