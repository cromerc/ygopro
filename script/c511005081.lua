--Reawakening of the Emperor
--帝王の再覚醒
--  By Shad3
--Edited by MLD
function c511005081.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511005081.target)
	e1:SetOperation(c511005081.activate)
	c:RegisterEffect(e1)
	if not c511005081.global_check then
		c511005081.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_CHAIN_SOLVED)
		ge1:SetOperation(c511005081.checkop)
		Duel.RegisterEffect(ge1,0)
	end
end
c511005081.collection={
	[9748752]=true;[51945556]=true;[15545291]=true;[23064604]=true;[23689697]=true;
	[69230391]=true;[69327790]=true;[87288189]=true;[87602890]=true;[96570609]=true;
	[4929256]=true;[57666212]=true;[60229110]=true;[65612386]=true;[85718645]=true;
	[73125233]=true;[26205777]=true;
}
function c511005081.checkop(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	if re:IsActiveType(TYPE_MONSTER) and re:GetCode()==EVENT_SUMMON_SUCCESS 
		and bit.band(rc:GetSummonType(),SUMMON_TYPE_ADVANCE)==SUMMON_TYPE_ADVANCE then
		rc:RegisterFlagEffect(511005081,RESET_EVENT+0x1fe0000,0,0)
	end
end
function c511005081.filter(c)
	return c:IsFaceup() and c:GetFlagEffect(511005081)>0 and bit.band(c:GetSummonType(),SUMMON_TYPE_ADVANCE)==SUMMON_TYPE_ADVANCE 
		and c:IsLevelAbove(5) and c511005081.collection[c:GetCode()]
end
function c511005081.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511005081.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
end
function c511005081.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectMatchingCard(tp,c511005081.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.HintSelection(g)
		Duel.RaiseSingleEvent(tc,EVENT_SUMMON_SUCCESS,e,r,rp,ep,0)
	end
end
