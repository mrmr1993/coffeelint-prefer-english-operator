module.exports = class RuleProcessor
  rule:
    name: 'prefer_english_operator'
    description: '''
      This rule prohibits &&, ||, ==, !=, and !.
      Use and, or, is, isnt, and not instead.
      Each can be disabled by setting
      allowedOperators[operator] = true
      where operator is one of "&&", "||", "==", "!=", and "!".
      '''
    allowedOperators:
      "&&": false
      "||": false
      "==": false
      "!=": false
      "!": false
    level: 'warn'
    message: 'Don\'t use &&, ||, == and !='

  lintLine: (line, lineApi) ->
    lineTokens = lineApi.getLineTokens()

    for token in lineTokens
      switch token[0]
      if token[0] in ['COMPARE', 'LOGIC', "UNARY"]
        location = token[2]
        substring = line[location.first_column..location.last_column]
        if tokenApi.config.allowedOperators[substring] == false
          return {context: "Found: #{hasNonEnglishOperators[0]}"}
