// 生体認証のタイプ(BioMetricsLoginBlocなどで使用)
enum BioType { IOS_FACE, IOS_FINGER, ANDROID_FACE, ANDROID_FINGER, NOTHING }

// ログイン設定画面のラジオボタンの種類(SettingRadioButtonBlocなどで使用)
enum RadioValue { ID_PASS, PASS, AUTO, PASSCODE }

// ユーザー情報確認画面の押されたボタンのタイプ(EditNicknameBlocなどで使用)
enum PressedButtonType { EDIT_ICON, SAVE_BUTTON }

/*
success：成功：sessionにログイン情報格納
fail：初期パスワード変更要求など
error：Auth処理でのエラー(ユーザIDやパスワード間違いなども含む)
*/
enum AuthFlowStatus { success, fail, id_error, user_error, pass_error, disable_error, error }

/*
success：成功：トップページに遷移
fail：入力項目不一致など
error：パスワード変更処理でのエラー(sessionなども含む)
*/
enum ChangePassFlowStatus { success, fail, reg_error, input_error, error }
