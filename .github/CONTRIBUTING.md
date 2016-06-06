# Contributing to Zeus

:tada: A big thank you for taking your time to contribute! You rock! :rocket:

Please read through this guideline before you contribute and do suggest changes on this document by submitting a Pull Request.

## Before You Start

### Code of Conduct

Please respect the [FreeCodeCamp Code of Conduct](https://www.freecodecamp.com/code-of-conduct)

If you find any breach of the code of conduct, please contact an existing collaborator in our [Gitter Chat](https://gitter.im/FreeCodeCamp/vagrant)

## Why You May Wish to Contribute?

One of the many reasons you might want to contribute to Zeus is that our community is very active, and we are glad to help you and teach you new skills along the way. You will certainly learn a lot during your time as a contributor.

## Knowledge about Zeus

In order to get started, you may wish to read up a little to get yourself up to speed. The recommended reading on the existing Zeus project follows this sequence. All of these materials are conveniently accessible via Github Wiki page of the Zeus repository.

1. Software Design: this contains crucial information on the philosophy of Zeus and displays it visually. When you contribute, please follow this pattern of software design or suggest a better version of it.
2. Public API and CLI: contains all the existing command line arguments and options so you will know what Zeus is currently capable of. If you discover anything that you wish to add as a new feature, you will be able to compare with existing ones to avoid duplication.
3. Software Specification: this document contains defined scope of new features, fixes, and improvements for releases. You can know the priorities of this project for the next release of this document.
4. Stack specific documentation: for each existing stack there is one specific Wiki page. If you are contributing to Python, say, then please read up on the Python Stack page.

Any other pages within the Wiki are optional for the purpose of contributing to Zeus.

## Background Knowledge

We prefer if you concentrate on one particular task, ideally where you are extremely good at. Say you develop in PHP, then write some features within the PHP directory of Zeus. In this case, you can have some recourse to the numerous resources we collected and organised per stack at the Resources page.

## How Can I Contribute?

### Reporting Bugs

Steps to report bugs:

1. Go to the [Issues](https://github.com/alayek/zeus/issues) page and find if the same bug has already been reported.
2. Submit your bug report with as much information as possible so we can reproduce the bug easily. Refer to [Atom Contributing Guidelines](https://github.com/atom/atom/blob/master/CONTRIBUTING.md) to have a look at a standard way to submit bug reports. Please use their template for submitting your report.

### Feature Request

Anyone is welcome to request new features, especially users who wish just to use Zeus. Please first find if the feature is already there by reading through the README.md of the repository and the Wiki pages for the specific stack. When you submit the feature request, please write as detailed as possible of why, how, and what you wish to use to implement. Again use the template for feature request from the [Atom Contributing Guidelines](https://github.com/atom/atom/blob/master/CONTRIBUTING.md).

## Code Contribution - The Real Deal

You wish to show off your coding skills, now is the time. Please follow this workflow structure to submit a Pull Request:

1. Fork the main repository.
2. On your forked repository, change to another branch from master so you do not mess up when you make a mistake. Develop on this new branch until maturity of your code. You can think of course resort to as many further sub-branches as you wish, but try not to develop on master branch in any case.
3. Once you are finished on your development branch, merge with your forked repository's master branch.
4. From the master branch of your fork, submit a Pull Request to the master of Zeus main repository.
5. Always include an upgrade of all the documentation and readme files that are affected by your change in code. The recommendation is to write your documentation ideally before your code and after you are finished coding, close off a final version of your documentation. You should always include documentation with your code. Don't forget to comment extensively on in your code as well.
6. Never ever pull in your own Pull Request, assign the Pull Request to one of the existing collaborators. If the majority of the collaborators tested your Pull Request and think it is good to go, then one of them will merge your Pull Request.

## Commit Message Style

Please follow the following style guide to write your commit messages borrowed from [Atom Contributing Guidelines](https://github.com/atom/atom/blob/master/CONTRIBUTING.md):

- Use the present tense ("Add feature" not "Added feature")
- Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
- Limit the first line to 72 characters or less
- Reference issues and pull requests liberally
- When only changing documentation, include [ci skip] in the commit description
- Always include a detailed body to state why and how you changed the code. Don't state what you changed, this is clear from the commit's content.
- Use bullet points for the body
- Add a footer to say something like: Closes \#45 which means that this commit closes Issue \#45
- Consider starting the commit message with an applicable emoji:
:art: when improving the format/structure of the code
:racehorse: when improving performance
:non-potable_water: when plugging memory leaks
:memo: when writing docs
:penguin: when fixing something on Linux
:apple: when fixing something on Mac OS
:checkered_flag: when fixing something on Windows
:bug: when fixing a bug
:fire: when removing code or files
:green_heart: when fixing the CI build
:white_check_mark: when adding tests
:lock: when dealing with security
:arrow_up: when upgrading dependencies
:arrow_down: when downgrading dependencies
:shirt: when removing linter warnings
