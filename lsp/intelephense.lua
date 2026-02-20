return {
  init_options = {
    -- THIS NEEDS TO BE licence not license
    -- Note the brithish spelling.
    licenceKey = os.getenv 'HOME' .. '/intelephense/licence.txt',
  },
  settings = {
    intelephense = {
      files = { maxSize = 1100000 },
      telemetry = { enabled = true },
    },
  },
}
