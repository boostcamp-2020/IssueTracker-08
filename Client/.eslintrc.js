module.exports = {
  plugins: ['prettier'],
  extends: ['airbnb-base', 'plugin:prettier/recommended'],
  parserOptions: {
    ecmaVersion: 7,
  },
  env: {
    es6: true,
    browser: true,
    node: true,
  },
  rules: {
    'prettier/prettier': 'error',
    'no-var': 'warn',
    'no-unused-vars': 'off',
  },
};
