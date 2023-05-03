import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
admin.initializeApp();


// export const helloWorld = functions
//   .region("europe-west6")
//   .https.onCall((data, context) => {
//     return "Hello there!";
//   });

// export const writeNewAuthUserToFirestore = functions
//   .region("europe-west6")
//   .auth.user()
//   .onCreate((user) => {
//     admin.firestore().collection("users").doc(user.uid).set({
//       "username": user.displayName,
//       "signupTimestamp": admin.firestore.FieldValue.serverTimestamp(),
//     });
//   });

export const handleTableUpdate = functions
  .region("europe-west6")
  .firestore.document("tables/{tableUid}")
  .onUpdate(async (change, context) => {
    const table = change.after.data();
    
    // If all players ready, start new game
    if (table.gameUid == null &&
      table.player1Ready &&
      table.player2Ready &&
      table.player3Ready &&
      table.player4Ready) {
      const deck = [
        "M1", "DN", "PX", "DG",
        "r2", "r3", "r4", "r5", "r6", "r7", "r8", "r9", "rX",
        "rJ", "rQ", "rK", "rA",
        "g2", "g3", "g4", "g5", "g6", "g7", "g8", "g9", "gX",
        "gJ", "gQ", "gK", "gA",
        "b2", "b3", "b4", "b5", "b6", "b7", "b8", "b9", "bX",
        "bJ", "bQ", "bK", "bA",
        "k2", "k3", "k4", "k5", "k6", "k7", "k8", "k9", "kX",
        "kJ", "kQ", "kK", "kA",
      ];

      // shuffle the cards
      for (let i = deck.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * i);
        const temp = deck[i];
        deck[i] = deck[j];
        deck[j] = temp;
      }

      let turn;
      if (deck.slice(0, 14).includes("M1")) {
        turn = "player1";
      } else if (deck.slice(14, 28).includes("M1")) {
        turn = "player2";
      } else if (deck.slice(28, 42).includes("M1")) {
        turn = "player3";
      } else if (deck.slice(42, 56).includes("M1")) {
        turn = "player4";
      }  

      const docRef = await admin.firestore().collection("games").add({
        "inPlay": [],
        "turn": turn,
        "player1Tichu": false,
        "player1GrandTichu": false,
        "player1Hand": deck.slice(0, 14),
        "player1Stitches": [],
        "player2Tichu": false,
        "player2GrandTichu": false,
        "player2Hand": deck.slice(14, 28),
        "player2Stitches": [],
        "player3Tichu": false,
        "player3GrandTichu": false,
        "player3Hand": deck.slice(28, 42),
        "player3Stitches": [],
        "player4Tichu": false,
        "player4GrandTichu": false,
        "player4Hand": deck.slice(42, 56),
        "player4Stitches": [],
      });
      admin.firestore().collection("tables").doc(change.after.id).update({
        "gameUid": docRef.id,
      });
      return;
    }
  });


