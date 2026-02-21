return {
  init_options = {
    -- THIS NEEDS TO BE licence not license
    -- Note the brithish spelling.
    licenceKey = os.getenv 'HOME' .. '/intelephense/licence.txt',
  },
  settings = {
    intelephense = {
      files = {
        maxSize = 1000000,
        exclude = {
          '**/.git/**',
          '**/CVS/**',
          '**/.hg/**',
          '**/.svn/**',
          '**/.DS_Store/**',
          '**/node_modules/**',
          '**/bower_components/**',
          '**/.history/**',
          '**/vendor/**/{vendor,tests}/**',
        },
      },
    },
  },
}
