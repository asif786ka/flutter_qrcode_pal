"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const admin = require("firebase-admin");
const functions = require("firebase-functions");
admin.initializeApp();
exports.onAdsNotification = functions.firestore.document("/Adsnotification/{anid}").onCreate(async (snap, context) => {
    var notification = snap.data();
    admin.messaging().sendToTopic("all_users", {
        notification: {
            icon: "skel",
            title: notification.title,
            body: notification.body,
            image: notification.image,
        },
        "data": {
            "click_action": "FLUTTER_NOTIFICATION_CLICK",
            "id": "1",
            "status": "done",
            "sound": "default",
            "screen": "/ads",
            "link": notification.link
        },
    });
});
exports.onNotification = functions.firestore.document("/notification/{nid}").onCreate(async (snap, context) => {
    var notification = snap.data();
    admin.messaging().sendToTopic("all_users", {
        notification: {
            icon: "skel",
            title: notification.title,
            body: notification.body,
            image: notification.image,
        },
        "data": {
            "click_action": "FLUTTER_NOTIFICATION_CLICK",
            "id": "1",
            "status": "done",
            "sound": "default",
            "screen": "/notification",
            "link": notification.link
        },
    });
});
//# sourceMappingURL=index.js.map