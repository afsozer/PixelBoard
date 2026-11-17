package com.akshaykadam.pixelboard.extension.updater;

import com.akshaykadam.pixelboard.extension.BuildConfig;

import org.junit.Assert;
import org.junit.Test;

public final class PixelBoardUpdateManagerTest {
    @Test
    public void updateCheckTargetsForkRepository() {
        Assert.assertEquals("afsozer/PixelBoard", BuildConfig.UPDATE_REPO_SLUG);
        Assert.assertEquals(
                "https://api.github.com/repos/afsozer/PixelBoard/releases/latest",
                PixelBoardUpdateManager.GITHUB_REPO_API);
        Assert.assertEquals(
                "https://github.com/afsozer/PixelBoard/releases",
                PixelBoardUpdateManager.GITHUB_REPO_RELEASES_WEB);
    }
}
