--Champion's Faction
--fixed by MLD
function c511005002.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCondition(c511005002.condition)
	e1:SetTarget(c511005002.target)
	e1:SetOperation(c511005002.activate)
	c:RegisterEffect(e1)
end
c511005002.collection={
	[70406920]=true;[46700124]=true;[89222931]=true;[96938777]=true;[18891691]=true;
	[501000079]=true;[49195710]=true;[20563387]=true;[93568288]=true;[47387961]=true;
	[19012345]=true;[35058857]=true;[6901008]=true;[60990740]=true;[75326861]=true;
	[32995007]=true;[96381979]=true;[80955168]=true;[70791313]=true;[16509093]=true;
	[83986578]=true;[3056267]=true;[10071456]=true;[47879985]=true;[89959682]=true;
	[62242678]=true;[22858242]=true;[91512835]=true;[18710707]=true;[87564352]=true;
	[23756165]=true;[50140163]=true;[87257460]=true;[15951532]=true;[6214884]=true;
	[22996376]=true;[54702678]=true;[38180759]=true;[6614221]=true;[45121025]=true;
	[5818798]=true;[4179849]=true;[14462257]=true;[29155212]=true;[55818463]=true;
	[20438745]=true;[72426662]=true;[53375573]=true;[44223284]=true;[17573739]=true;
	[8561192]=true;[78651105]=true;[19028307]=true;[10613952]=true;[21223277]=true;
	[40732515]=true;[23659124]=true;[29515122]=true;[5901497]=true;[71411377]=true;
	[11250655]=true;[19748583]=true;[60992364]=true;[27337596]=true;[61370518]=true;
	[16768387]=true;[12817939]=true;[58206034]=true;[85313220]=true;[88307361]=true;
	[84025439]=true;[51371017]=true;[86327225]=true;[74069667]=true;[83303851]=true;
	[47198668]=true;[8463720]=true;[82956492]=true;[44852429]=true;[44186624]=true;
	[15939229]=true;[3758046]=true;[27873305]=true;[56619314]=true;[92536468]=true;
	[74583607]=true;[987311]=true;[79109599]=true;[99426834]=true;[30741334]=true;
	[67136033]=true;[39711336]=true;[30646525]=true;[70583986]=true;[2316186]=true;
	[75917088]=true;[43791861]=true;[20193924]=true;[8763963]=true;[34408491]=true;
	[29424328]=true;[89832901]=true;[56907389]=true;[24857466]=true;[53982768]=true;
	[5309481]=true;[75675029]=true;[69455834]=true;[82213171]=true;[45425051]=true;
	[28290705]=true;[64514622]=true;[22910685]=true;[511001914]=true;[511000141]=true;
	[511001690]=true;[82382815]=true;
}
function c511005002.condition(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	return d and d:IsFaceup() 
		and (c511005002.collection[d:GetCode()] or d:IsSetCard(0x81) or d:IsSetCard(0xda) or d:IsSetCard(0xbe) or d:IsSetCard(0x21a))
end
function c511005002.filter(c,e,tp)
	return (c511005002.collection[c:GetCode()] or c:IsSetCard(0x81) or c:IsSetCard(0xda) or c:IsSetCard(0xbe) or c:IsSetCard(0x21a)) 
		and c:IsLevelBelow(4) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511005002.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>2 
		and Duel.IsExistingMatchingCard(c511005002.filter,tp,LOCATION_DECK,0,3,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,3,tp,LOCATION_DECK)
end
function c511005002.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=2 then return end
	local g=Duel.GetMatchingGroup(c511005002.filter,tp,LOCATION_DECK,0,nil,e,tp)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) or g:GetCount()<3 then return end
	local c=e:GetHandler()
	local fid=c:GetFieldID()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=g:Select(tp,3,3,nil)
	local tc=sg:GetFirst()
	while tc do
		Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP_ATTACK)
		local e1=Effect.CreateEffect(tc)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1,true)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2,true)
		tc:RegisterFlagEffect(51105002,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1,fid)
		tc=sg:GetNext()
	end
	Duel.SpecialSummonComplete()
	sg:KeepAlive()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetLabel(fid)
	e1:SetLabelObject(sg)
	e1:SetCondition(c511005002.descon)
	e1:SetOperation(c511005002.desop)
	Duel.RegisterEffect(e1,tp)
end
function c511005002.desfilter(c,fid)
	return c:GetFlagEffectLabel(51105002)==fid
end
function c511005002.descon(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if not g:IsExists(c511005002.desfilter,1,nil,e:GetLabel()) then
		g:DeleteGroup()
		e:Reset()
		return false
	else return true end
end
function c511005002.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local tg=g:Filter(c511005002.desfilter,nil,e:GetLabel())
	g:DeleteGroup()
	Duel.Destroy(tg,REASON_EFFECT)
end
