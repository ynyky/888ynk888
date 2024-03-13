with owners as (select author as userid, count(*) as ownedboards from documents group by author)
select u.displayname as name, e.email as email, s.subjectname as saml_subjectname, u.company as org, to_char(u.createdat, 'YYYY-MM-DD') as creation, to_char(max(l.createdat), 'YYYY-MM-DD') as lastlogin, ownedboards
from userlogins l
left join users u using (userid)
left join emails e using (userid)
left join owners o using (userid)
left join samlusers s using (userid)
where namedguest is false and l.createdat < '#{@end_date_report}'
group by u.displayname, e.email, s.subjectname, u.createdat, u.company, ownedboards
