# Release Software docker action
这是一个自用的 GitHub 容器操作，只可参考；主要功能用于发布软件，主要分为分为两步：
1.使用阿里云 OSS 命令行工具推送固件到 OSS 上
2.将软件发布信息推送到 OTA 服务器上

## 输入参数
### `args`
**Required** 固件文件名，请保证固件在工作目录的根目录.

### `otaSoftwareToken`
**Required** 固件唯一 Token，类似UUID，请在 OTA 服务上获取.

### `otaServerUrl`
**Required** OTA 服务器地址.

### `otaServerUser`
**Required** OTA 服务器用户名.

### `otaServerPwd`
**Required** OTA 服务器密码.

### `aliyunOssUrl`
**Required** OSS 目标地址.

### `aliyunOssEndpoint`
**Required** OSS 节点.

### `aliyunAccessId`
**Required** OSS access-key-id.

### `aliyunAccessSecret`
**Required** OSS access-key-secret.

## Example usage
uses: niiaaip/release-software
with:
  args: test_v1.1.1.bin
  secretId: ${{ secrets.SECRET_ID }}
  secretKey: ${{ secrets.SECRET_KEY }}
  bucket: ${{ secrets.BUCKET }}
