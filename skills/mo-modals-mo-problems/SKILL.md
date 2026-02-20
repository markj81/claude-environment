---
name: mo-modals-mo-problems
description: "Help users understand when to use modals and when to avoid them. Use when users ask about modals, dialogs, popups, overlays, or when they need guidance on choosing the right interaction pattern. The skill is named after the Notorious B.I.G. song 'Mo Money Mo Problems' because modals often create more UX problems than they solve."
disable-model-invocation: false
version: 1.0.0
---

# Mo' Modals, Mo' Problems

## The Core Philosophy

> *"Mo' modals, mo' problems."*

This skill helps you recognize that while modals (dialogs, popups, overlays) seem convenient, they often create more user experience problems than they solve. Use this skill to evaluate whether a modal is the right choice—or if there's a better alternative.

## When NOT to Use Modals (The Problems)

### 1. Complex Forms
**Don't use modals for:**
- Multi-step forms or wizards
- Forms with many fields
- Anything requiring scrolling inside the modal

**Why:** Users hate re-entering data if they accidentally close the modal. Scrolling inside modals is a terrible experience on mobile.

**Better alternative:** Inline expansion, dedicated pages, or a stepper pattern on the same page.

### 2. Critical Actions with Consequences
**Don't use modals for:**
- Delete confirmations that matter
- Payment/checkout flows
- Legal agreements or terms acceptance
- Data that can't be recovered

**Why:** Modals are easy to dismiss accidentally (especially on mobile). Users often click through without reading.

**Better alternative:** Dedicated confirmation pages, inline undo patterns, or clearly accessible cancellation options.

### 3. Important Information Users Need
**Don't use modals for:**
- Terms and conditions
- Privacy policies
- Feature announcements
- Tutorial content

**Why:** Users will click anything to close it and get back to their task. They won't read it.

**Better alternative:** Footer links, toast notifications for brief updates, or a dedicated "What's New" page.

### 4. Primary Navigation or Core Flows
**Don't use modals for:**
- Login/signup as the main way to access content
- Main content that should be a page
- Navigation between major sections

**Why:** Modals interrupt user flow and feel like obstacles. They fragment your app's architecture.

**Better alternative:** Full pages, side panels for supplementary content.

### 5. Mobile Experiences
**Avoid modals on mobile because:**
- They take over the full screen anyway
- Hard to dismiss accidentally
- No visible backdrop to tap
- Gesture conflicts with swipe-to-close

**Better alternative:** Bottom sheets, full-screen transitions, native navigation patterns.

## When Modals ARE Appropriate

### 1. Quick, Discrete Confirmations
**Good use cases:**
- "Are you sure you want to log out?"
- "Delete this item?"
- "Unsubscribe from this?"

**Key characteristics:**
- Single action, single confirmation
- No data entry required
- Reversible or low-consequence

### 2. Focused Micro-Interactions
**Good use cases:**
- Selecting a date from a datepicker
- Picking from a small list of options
- Quick settings toggle
- Adding a single item to a collection

**Key characteristics:**
- Small, self-contained task
- 2-3 clicks/taps maximum
- User expects quick interaction

### 3. System Alerts
**Good use cases:**
- Network error notifications
- Session timeout warnings
- Browser permission requests
- Critical system messages

**Key characteristics:**
- Non-negotiable system communication
- Requires acknowledgment
- Blocks until resolved

### 4. Editing Inline Content
**Good use cases:**
- Quick text edits
- Renaming something
- Adding a comment

**Key characteristics:**
- Brief interaction
- Context stays visible
- Easy to cancel and return

## Modal Anti-Patterns to Avoid

### The "Are you sure?" Overlord
```
Don't: Delete → Modal "Are you sure?" → Confirm → Modal "Deleted!"
Do: Delete → Inline confirmation with Undo button
```

### The Terms and Conditions Trap
```
Don't: Show modal with 2000 words of legal text + "I accept"
Do: Link to full terms, show brief summary in modal if needed
```

### The Scroll of Doom
```
Don't: 15-field form inside a modal
Do: Use inline expansion or a dedicated page
```

### The Mobile Nightmare
```
Don't: Modal with close button only in top-right corner
Do: Clear X button, swipe-to-dismiss, clear "Cancel" action
```

### The Backdrop Blindness
```
Don't: No visible backdrop or unclear modal boundaries
Do: Clear overlay with visible boundaries and focus trap
```

## Accessibility Requirements (Non-Negotiable)

### Must Have:
1. **Focus trap** - Keyboard focus must stay within the modal
2. **Escape to close** - ESC key should close the modal
3. **Proper ARIA** - `role="dialog"`, `aria-modal="true"`, `aria-labelledby`
4. **Focus return** - Return focus to trigger element when closed
5. **Screen reader announcement** - Modal entry should be announced
6. **Visible close button** - Don't rely only on ESC or backdrop click

### Must Avoid:
- Auto-focusing inputs that haven't been requested
- Trapping focus in nested elements
- Opening modals without user trigger (no auto-popups)
- Scrolling the background while modal is open

## Quick Decision Framework

Ask yourself these questions:

1. **Can this wait?** → If yes, don't use a modal
2. **Does the user need to see context behind it?** → If yes, don't use a modal
3. **Is there data entry involved?** → If complex, don't use a modal
4. **Is this a core user flow?** → If yes, make it a page
5. **What happens on mobile?** → If problematic, don't use a modal
6. **Can I provide an undo?** → If yes, prefer inline with undo over modal

If you still think a modal is right, ask one more question:

**"Would I be frustrated if this modal appeared right now while I was trying to do something important?"**

If the answer is yes, find another way.

## Usage Examples

- "Should I use a modal for this login flow?"
- "What's the best way to confirm a delete action?"
- "Why do users hate modals so much?"
- "Help me design a confirmation dialog"
- "When should I use a bottom sheet instead of a modal?"
- "Is it okay to show a modal when the page loads?"
- "How do I make my modal accessible?"

## TL;DR

**Modals interrupt. Modals frustrate. Modals hide important content.**

Use them sparingly—for quick confirmations, focused micro-interactions, and system alerts only. Everything else deserves a proper page, inline expansion, or a less intrusive pattern.

*Remember: Mo' modals, mo' problems.*
