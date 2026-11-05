# Releasing

1. Make sure `main` is green: `build`, `scripts`, `snapshots` and `docs` jobs.
2. In a pull request, move the entries under `[Unreleased]` into a new
   `## [X.Y.Z] - YYYY-MM-DD` section of `CHANGELOG.md`. Apply `docs/versioning.md`
   to choose the number.
3. Merge the pull request (rebase), then update your local `main`.
4. Create and push an annotated tag from the `main` commit:

   ```bash
   git tag -a vX.Y.Z -m "vX.Y.Z"
   git push origin vX.Y.Z
   ```

5. The `Release` workflow validates the tag and the changelog section, checks the
   commit is on `main`, runs `swift test`, and publishes the GitHub Release.

The workflow does not rerun snapshot tests or the documentation build, so step 1
is the guarantee for them.

## Rules

- Never move or delete a published tag. Fix mistakes with a new patch release.
- A tag must match `vMAJOR.MINOR.PATCH` or `vMAJOR.MINOR.PATCH-prerelease`.
- A release without a non-empty changelog section fails before anything is published.
