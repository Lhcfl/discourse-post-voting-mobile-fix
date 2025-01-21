import Component from "@glimmer/component";
import { action } from "@ember/object";
import { service } from "@ember/service";
import DButton from "discourse/components/d-button";
import { ajax } from "discourse/lib/ajax";
import { popupAjaxError } from "discourse/lib/ajax-error";
import PostVotingButton from "discourse/plugins/discourse-post-voting/discourse/components/post-voting-button";

export default class MobileVoteButtons extends Component {
  static hidden() {
    return false;
  }

  static shouldRender(args) {
    console.log(args.post);
    return args.post.topic?.is_post_voting;
  }

  @service appEvents;

  get upVoted() {
    return this.args.post.post_voting_user_voted_direction === "up";
  }

  get downVoted() {
    return this.args.post.post_voting_user_voted_direction === "down";
  }

  get voteCount() {
    return String(this.args.post.post_voting_vote_count);
  }

  get disabled() {
    return false;
    // return document.querySelector(
    //   `[data-post-id="${this.args.post.id}"] .post-voting-button-upvote`
    // ).disabled;
  }

  // Very temporary operation, need to be redone after "discourse/plugins/discourse-post-voting/discourse/widgets/post-voting-post" is upgraded from widget to component
  @action
  veryDirtyClick(direction) {
    document
      .querySelector(
        `[data-post-id="${this.args.post.id}"] .post-voting-button-${direction}vote`
      )
      .click();
    setTimeout(() => {
      document
        .querySelector(
          `[data-post-id="${this.args.post.id}"] .post-voting-post-toggle-voters`
        )
        .click();
    }, 1000);
  }

  @action
  upVote() {
    this.veryDirtyClick("up");
  }

  @action
  downVote() {
    this.veryDirtyClick("down");
  }

  <template>
    <div class="post-voting-buttons-mobile-fix">
      <PostVotingButton
        @direction="up"
        @loading={{false}}
        @voted={{this.upVoted}}
        @removeVote={{this.upVote}}
        @vote={{this.upVote}}
        @disabled={{this.disabled}}
      />
      {{!-- <DButton @translatedLabel={{this.voteCount}} /> --}}
      <span class="voting-count">
        {{this.voteCount}}
      </span>
      <PostVotingButton
        @direction="down"
        @loading={{false}}
        @voted={{this.downVoted}}
        @removeVote={{this.downVote}}
        @vote={{this.downVote}}
        @disabled={{this.disabled}}
      />
    </div>
  </template>
}
