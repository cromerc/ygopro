--エクシーズ熱戦！！
function c511002757.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c511002757.condition)
	e1:SetCost(c511002757.cost)
	e1:SetTarget(c511002757.target)
	e1:SetOperation(c511002757.activate)
	c:RegisterEffect(e1)
end
function c511002757.cfilter(c,e,tp)
	return c:IsType(TYPE_XYZ) and c:GetPreviousControler()==tp and (not e or c:IsRelateToEffect(e))
end
function c511002757.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511002757.cfilter,1,nil,nil,tp) and eg:IsExists(c511002757.cfilter,1,nil,nil,1-tp)
end
function c511002757.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c511002757.filter(c,e,tp,eg)
	return c:IsType(TYPE_XYZ) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) 
		and eg:IsExists(c511002757.rkfilter,1,nil,c:GetRank(),tp)
end
function c511002757.rkfilter(c,rk,tp)
	return c:GetRank()==rk and c:GetPreviousControler()==tp
end
function c511002757.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.GetLocationCount(1-tp,LOCATION_MZONE,1-tp)>0
		and Duel.IsExistingMatchingCard(c511002757.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp,eg) 
		and Duel.GetFieldGroupCount(1-tp,LOCATION_EXTRA,0)>0 end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,PLAYER_ALL,0)
end
function c511002757.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Group.CreateGroup()
	local tc1=nil
	local tc2=nil
	local tg1=eg:Filter(c511002757.cfilter,nil,e,tp)
	local tg2=eg:Filter(c511002757.cfilter,nil,e,1-tp)
	local fid=e:GetHandler():GetFieldID()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		tc1=Duel.SelectMatchingCard(tp,c511002757.filter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,eg):GetFirst()
		local pos=POS_FACEUP
		if Duel.GetTurnPlayer()==tp then pos=POS_FACEUP_ATTACK end
		if tc1 and Duel.SpecialSummonStep(tc1,0,tp,tp,false,false,pos) then
			tc1:RegisterFlagEffect(51102757,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE,0,1,fid)
		end
	end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_SPSUMMON)
		tc2=Duel.SelectMatchingCard(1-tp,c511002757.filter,1-tp,LOCATION_EXTRA,0,1,1,nil,e,1-tp,eg):GetFirst()
		local pos=POS_FACEUP
		if Duel.GetTurnPlayer()~=tp then pos=POS_FACEUP_ATTACK end
		if tc2 and Duel.SpecialSummonStep(tc2,0,1-tp,1-tp,false,false,pos) then
			tc2:RegisterFlagEffect(51102757,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE,0,1,fid)
		end
	end
	Duel.SpecialSummonComplete()
	if tc1 then
		sg:AddCard(tc1)
		Duel.Overlay(tc1,tg1)
	end
	if tc2 then
		sg:AddCard(tc2)
		Duel.Overlay(tc2,tg2)
	end
	if tc1 and tc2 then
		if Duel.GetTurnPlayer()==tp then
			Duel.CalculateDamage(tc1,tc2)
		else
			Duel.CalculateDamage(tc2,tc1)
		end
	end
	sg:KeepAlive()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetCountLimit(1)
	e1:SetLabel(fid)
	e1:SetLabelObject(sg)
	e1:SetCondition(c511002757.descon)
	e1:SetOperation(c511002757.desop)
	Duel.RegisterEffect(e1,tp)
end
function c511002757.desfilter(c,fid)
	return c:GetFlagEffectLabel(51102757)==fid
end
function c511002757.descon(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if not g:IsExists(c511002757.desfilter,1,nil,e:GetLabel()) then
		g:DeleteGroup()
		e:Reset()
		return false
	else return true end
end
function c511002757.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local tg=g:Filter(c511002757.desfilter,nil,e:GetLabel())
	Duel.Destroy(tg,REASON_EFFECT)
end
