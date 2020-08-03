import { getInput } from '@actions/core';
import { includes } from 'lodash-es';

class Input {

  static isValidFolderName(folderName) {
    const validFolderName = new RegExp(/^(\.|\.\/)?(\.?\w+([-_]?\w+)*\/?)*$/);

    return validFolderName.test(folderName);
  }

  static getFromUser() {
    // Input variables specified in workflow using "with" prop.
    const unityVersion = getInput('unityVersion') || '2019.2.11f1';
    const rawProjectPath = getInput('projectPath') || '.';
    const rawUseHostNetwork = getInput('useHostNetwork') || 'false';
    const args = getInput('args') || '';

    // Validate input
    if (!this.isValidFolderName(rawArtifactsPath)) {
      throw new Error(`Invalid artifactsPath "${rawArtifactsPath}"`);
    }

    if (!this.isValidFolderName(rawProjectPath)) {
      throw new Error(`Invalid projectPath "${rawProjectPath}"`);
    }

    if (rawUseHostNetwork !== 'true' && rawUseHostNetwork !== 'false') {
      throw new Error(`Invalid useHostNetwork "${rawUseHostNetwork}"`);
    }

    // Sanitise input
    const projectPath = rawProjectPath.replace(/\/$/, '');
    const useHostNetwork = rawUseHostNetwork === 'true';

    // Return sanitised input
    return {
      unityVersion,
      projectPath,
      useHostNetwork,
      args,
    };
  }
}

export default Input;
