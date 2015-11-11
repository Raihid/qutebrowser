Feature: Yanking and pasting.
    :yank and :paste can be used to copy/paste the URL or title from/to the
    clipboard and primary selection.

    Background:
        Given I open data/yankpaste.html

    Scenario: Yanking URLs to clipboard
        When I run :yank
        Then the message "Yanked URL to clipboard: http://localhost:(port)/data/yankpaste.html" should be shown.
        And the clipboard should contain "http://localhost:(port)/data/yankpaste.html"

    Scenario: Yanking URLs to primary selection
        When selection is supported
        And I run :yank --sel
        Then the message "Yanked URL to primary selection: http://localhost:(port)/data/yankpaste.html" should be shown.
        And the primary selection should contain "http://localhost:(port)/data/yankpaste.html"

    Scenario: Yanking title to clipboard
        When I wait for regex "Changing title for idx \d to 'Test title'" in the log
        And I run :yank --title
        Then the message "Yanked title to clipboard: Test title" should be shown.
        And the clipboard should contain "Test title"

    Scenario: Yanking domain to clipboard
        When I run :yank --domain
        Then the message "Yanked domain to clipboard: http://localhost:(port)" should be shown.
        And the clipboard should contain "http://localhost:(port)"

    Scenario: Pasting an URL
        When I put "http://localhost:(port)/data/hello.txt" into the clipboard
        And I run :paste
        And I wait until data/hello.txt is loaded
        Then the requests should be:
            data/hello.txt

    Scenario: Pasting an URL from primary selection
        When selection is supported
        And I put "http://localhost:(port)/data/hello2.txt" into the primary selection
        And I run :paste --sel
        And I wait until data/hello2.txt is loaded
        Then the requests should be:
            data/hello2.txt