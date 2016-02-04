/**
 * Created by vimukthi on 2/3/16.
 */
Accounts.onCreateUser(function (options, user) {
    user['level'] = 0;
    user['mobile'] = options['mobile'];
    user['website'] = options['website'];
    user['website'] = options['website'];
    user['address'] = options['address'];

    return user;
})