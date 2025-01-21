import { apiInitializer } from "discourse/lib/api";
import MobileVoteButtons from "../components/mobile-vote-buttons";

export default apiInitializer("1.8.0", (api) => {
  // api.decorateWidget("post-menu:before", function (helper) {
  //   const result = [];
  //   const model = helper.getModel();
  //   if (model.topic?.is_post_voting) {
  //     const postVotingPost = helper.attach("post-voting-post", {
  //       count: model.get("post_voting_vote_count"),
  //       post: model,
  //     });
  //     result.push(postVotingPost);
  //   }
  //   return result;
  // });

  const site = api.container.lookup("service:site");

  if (!site.mobileView) {
    return;
  }

  api.registerValueTransformer(
    "post-menu-buttons",
    ({ value: dag, context: { firstButtonKey } }) => {
      dag.add("post-voting-buttons", MobileVoteButtons, {
        before: firstButtonKey,
      });
    }
  );
});
