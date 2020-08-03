import * as core from '@actions/core';
import { Action, Docker, Input, ImageTag, Output } from './model';

async function action() {
  Action.checkCompatibility();

  const { dockerfile, workspace, actionFolder } = Action;
  const {
    unityVersion,
    projectPath,
    useHostNetwork,
    args,
  } = Input.getFromUser();
  const baseImage = ImageTag.createForBase(unityVersion);

  // Build docker image
  const actionImage = await Docker.build({ path: actionFolder, dockerfile, baseImage });

  // Run docker image
  await Docker.run(actionImage, {
    workspace,
    unityVersion,
    projectPath,
    useHostNetwork,
    args,
  });
}

action().catch(error => {
  core.setFailed(error.message);
});
