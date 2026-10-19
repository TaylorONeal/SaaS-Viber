import importlib.util
import unittest
from pathlib import Path

spec = importlib.util.spec_from_file_location('review', Path(__file__).resolve().parents[2] / 'scripts/check-hardening-review.py')
review = importlib.util.module_from_spec(spec)
spec.loader.exec_module(review)

class ReviewTests(unittest.TestCase):
    def record(self):
        item = dict.fromkeys(('id', 'evidence', 'minimal_fix', 'test', 'regression_risk', 'recovery', 'release_dependency'), 'synthetic')
        item.update(priority='P1', classification='untested-risk', status='open')
        return dict(app='fixture', commit='abc', environment='test', reviewed_at='2026-10-19', owner='reviewer', findings=[item])

    def test_deferred_priority_risk_still_blocks(self):
        record = self.record()
        record['findings'][0]['status'] = 'deferred'
        errors, blockers = review.validate(record)
        self.assertFalse(errors)
        self.assertTrue(blockers)

    def test_verified_requires_proof(self):
        record = self.record()
        record['findings'][0]['status'] = 'verified'
        self.assertTrue(review.validate(record)[0])
        record['findings'][0]['verification'] = 'synthetic restore assertion passed'
        self.assertEqual(review.validate(record), ([], []))

    def test_not_applicable_cannot_bypass_classification(self):
        record = self.record()
        record['findings'][0].update(status='not-applicable', reason='no backend')
        self.assertTrue(review.validate(record)[0])
        record['findings'][0]['classification'] = 'not-applicable'
        self.assertEqual(review.validate(record), ([], []))

    def test_malformed_empty_and_duplicate_records(self):
        for record in (None, {}, {'findings': []}):
            self.assertTrue(review.validate(record)[0])
        record = self.record()
        record['findings'].append(record['findings'][0].copy())
        self.assertTrue(review.validate(record)[0])

    def test_post_traction_cannot_hide_high_priority(self):
        record = self.record()
        record['findings'][0].update(classification='post-traction', status='deferred')
        self.assertTrue(review.validate(record)[0])

if __name__ == '__main__':
    unittest.main()
